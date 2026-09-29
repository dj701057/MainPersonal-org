#!/usr/bin/env python3
"""Email the nightly Apex test report.

Usage: send-apex-report-email.py <report-dir>

Environment:
  SMTP_CONNECTION_URL  smtps://user%40gmail.com:APPPASSWORD@smtp.gmail.com:465  (secret)
                       smtp:// or smtp+starttls:// use STARTTLS on port 587
  SMTP_FROM            sender address (defaults to the SMTP user)
  DEV_TEAM_EMAILS      comma-separated recipients
  REPORT_KIND          success | failure
  GITHUB_*             added to the email when present (repo, commit, run link)
"""

import json
import os
import smtplib
import socket
import ssl
import sys
import time
from email.message import EmailMessage
from pathlib import Path
from urllib.parse import unquote, urlparse

ATTEMPTS = 3
BACKOFF_SECONDS = (5, 10)


def smtp_settings(url):
    parsed = urlparse(url)
    scheme = parsed.scheme.lower()
    if scheme not in ("smtps", "smtp", "smtp+starttls"):
        raise ValueError(f"unsupported SMTP scheme '{scheme}'")
    use_ssl = scheme == "smtps"
    return {
        "host": parsed.hostname,
        "port": parsed.port or (465 if use_ssl else 587),
        "user": unquote(parsed.username or ""),
        # Gmail shows app passwords in groups of 4; the spaces are not part of it
        "password": unquote(parsed.password or "").replace(" ", ""),
        "ssl": use_ssl,
    }


def ipv4_connection(host, port, timeout):
    # GitHub runners have flaky IPv6 routes to Gmail, so connect over IPv4.
    # TLS still verifies against the host name, not the IP.
    address = socket.getaddrinfo(host, port, socket.AF_INET, socket.SOCK_STREAM)[0][4][0]
    return socket.create_connection((address, port), timeout)


class SMTPv4(smtplib.SMTP):
    def _get_socket(self, host, port, timeout):
        return ipv4_connection(host, port, timeout)


class SMTPSSLv4(smtplib.SMTP_SSL):
    def _get_socket(self, host, port, timeout):
        return self.context.wrap_socket(ipv4_connection(host, port, timeout), server_hostname=host)


def send(settings, message):
    context = ssl.create_default_context()
    if settings["ssl"]:
        server = SMTPSSLv4(settings["host"], settings["port"], timeout=60, context=context)
    else:
        server = SMTPv4(settings["host"], settings["port"], timeout=60)
        server.starttls(context=context)
    with server:
        if settings["user"]:
            server.login(settings["user"], settings["password"])
        server.send_message(message)


def build_message(report_dir, sender, recipients, kind):
    evaluation = {}
    eval_path = report_dir / "apex-test-evaluation.json"
    if eval_path.exists():
        evaluation = json.loads(eval_path.read_text(encoding="utf-8"))

    run_no = os.environ.get("GITHUB_RUN_NUMBER", "local")
    if kind == "success" and evaluation.get("ok"):
        subject = f"[MainPersonalOrg] Nightly Apex tests passed (#{run_no})"
    elif evaluation.get("failing"):
        subject = f"[MainPersonalOrg] Nightly Apex tests failed: {evaluation['failing']} failing (#{run_no})"
    else:
        subject = f"[MainPersonalOrg] Nightly Apex run had a problem (#{run_no})"

    html_path = report_dir / "apex-test-report.html"
    txt_path = report_dir / "apex-test-report.txt"
    body_html = html_path.read_text(encoding="utf-8") if html_path.exists() else "<p>No report was produced.</p>"
    body_txt = txt_path.read_text(encoding="utf-8") if txt_path.exists() else "No report was produced.\n"

    server = os.environ.get("GITHUB_SERVER_URL")
    repo = os.environ.get("GITHUB_REPOSITORY")
    run_id = os.environ.get("GITHUB_RUN_ID")
    if server and repo and run_id:
        run_url = f"{server}/{repo}/actions/runs/{run_id}"
        sha = os.environ.get("GITHUB_SHA", "")[:7]
        footer = f"Repository: {repo} · Commit: {sha} · Run: {run_url}"
        body_html += (
            f'<p style="font-family:Segoe UI,Arial,sans-serif;font-size:12px;color:#57606a">'
            f'Repository: {repo} · Commit: {sha} · <a href="{run_url}">View run #{run_no}</a></p>'
        )
        body_txt += f"\n{footer}\n"

    message = EmailMessage()
    message["Subject"] = subject
    message["From"] = sender
    message["To"] = ", ".join(recipients)
    message.set_content(body_txt)
    message.add_alternative(body_html, subtype="html")
    message.add_attachment(body_txt.encode("utf-8"), maintype="text", subtype="plain", filename="apex-test-report.txt")
    return message


def main():
    report_dir = Path(sys.argv[1] if len(sys.argv) > 1 else "test-results")
    url = os.environ.get("SMTP_CONNECTION_URL", "").strip()
    if not url:
        print("SMTP_CONNECTION_URL is not configured", file=sys.stderr)
        return 1
    recipients = [r.strip() for r in os.environ.get("DEV_TEAM_EMAILS", "").split(",") if r.strip()]
    if not recipients:
        print("DEV_TEAM_EMAILS is not configured", file=sys.stderr)
        return 1

    settings = smtp_settings(url)
    sender = os.environ.get("SMTP_FROM", "").strip() or settings["user"]
    message = build_message(report_dir, sender, recipients, os.environ.get("REPORT_KIND", "failure"))

    for attempt in range(1, ATTEMPTS + 1):
        try:
            send(settings, message)
            print(f"Sent '{message['Subject']}' to {len(recipients)} recipient(s)")
            return 0
        except smtplib.SMTPAuthenticationError as exc:
            print(f"SMTP authentication failed (check the app password and %40 in the user): {exc}", file=sys.stderr)
            return 1
        except (OSError, smtplib.SMTPException) as exc:
            print(f"Attempt {attempt}/{ATTEMPTS} failed: {exc}", file=sys.stderr)
            if attempt < ATTEMPTS:
                time.sleep(BACKOFF_SECONDS[attempt - 1])
    return 1


if __name__ == "__main__":
    sys.exit(main())
