#!/usr/bin/env python3
"""Turn `sf apex run test --result-format json` output into the nightly report files.

Usage: build-apex-report.py <report-dir>

Reads  <report-dir>/apex-test-result.json
Writes <report-dir>/apex-test-evaluation.json  (summary used by the workflow)
       <report-dir>/apex-test-report.txt       (email attachment)
       <report-dir>/apex-test-report.html      (email body)

Exit code: 0 when every test passed, 1 when tests failed or the result is unusable.
"""

import html
import json
import sys
from pathlib import Path

COVERAGE_TARGET = 75.0
LOW_COVERAGE_LIMIT = 25  # classes listed in the "below target" table


def load_result(path):
    try:
        text = path.read_text(encoding="utf-8-sig")
    except FileNotFoundError:
        return None, f"{path.name} was not produced"
    start = text.find("{")  # the CLI can print warnings before the JSON
    if start < 0:
        return None, f"{path.name} contains no JSON"
    try:
        return json.loads(text[start:]), None
    except json.JSONDecodeError as exc:
        return None, f"{path.name} is not valid JSON: {exc}"


def to_float(value):
    try:
        return float(str(value).rstrip("%"))
    except (TypeError, ValueError):
        return None


def evaluate(data, error):
    ev = {
        "ok": False,
        "error": error,
        "outcome": "Unknown",
        "testRunId": None,
        "testsRan": 0,
        "passing": 0,
        "failing": 0,
        "skipped": 0,
        "orgWideCoverage": None,
        "testRunCoverage": None,
        "executionTime": None,
        "failures": [],
        "lowCoverage": [],
    }
    if data is None:
        return ev

    result = data.get("result") or {}
    summary = result.get("summary") or {}
    if not summary:
        ev["error"] = data.get("message") or "The CLI returned no test summary (run may have timed out)"
        ev["testRunId"] = result.get("testRunId")
        return ev

    ev.update(
        outcome=summary.get("outcome", "Unknown"),
        testRunId=summary.get("testRunId"),
        testsRan=int(summary.get("testsRan") or 0),
        passing=int(summary.get("passing") or 0),
        failing=int(summary.get("failing") or 0),
        skipped=int(summary.get("skipped") or 0),
        orgWideCoverage=to_float(summary.get("orgWideCoverage")),
        testRunCoverage=to_float(summary.get("testRunCoverage")),
        executionTime=summary.get("testExecutionTime") or summary.get("testTotalTime"),
    )

    for test in result.get("tests") or []:
        if test.get("Outcome") in ("Fail", "CompileFail"):
            ev["failures"].append(
                {
                    "name": test.get("FullName")
                    or f"{(test.get('ApexClass') or {}).get('Name', '?')}.{test.get('MethodName', '?')}",
                    "message": (test.get("Message") or "").strip(),
                    "stackTrace": (test.get("StackTrace") or "").strip(),
                }
            )

    coverage = (result.get("coverage") or {}).get("coverage") or []
    low = []
    for item in coverage:
        pct = to_float(item.get("coveredPercent"))
        if pct is not None and pct < COVERAGE_TARGET and (item.get("totalLines") or 0) > 0:
            low.append({"name": item.get("name"), "percent": pct, "lines": item.get("totalLines")})
    ev["lowCoverage"] = sorted(low, key=lambda c: (c["percent"], c["name"] or ""))

    ev["ok"] = ev["failing"] == 0 and ev["testsRan"] > 0
    if ev["testsRan"] == 0:
        ev["error"] = "No tests ran"
    return ev


def fmt_pct(value):
    return "n/a" if value is None else f"{value:.0f}%"


def build_text(ev):
    lines = [
        "Nightly Apex tests - MainPersonalOrg",
        "",
        f"Outcome:           {ev['outcome']}",
        f"Tests ran:         {ev['testsRan']}",
        f"Passed / failed:   {ev['passing']} / {ev['failing']}  (skipped {ev['skipped']})",
        f"Org-wide coverage: {fmt_pct(ev['orgWideCoverage'])}  (target {COVERAGE_TARGET:.0f}%)",
        f"Test run ID:       {ev['testRunId'] or 'n/a'}",
    ]
    if ev["error"]:
        lines += ["", f"Problem: {ev['error']}"]
    if ev["failures"]:
        lines += ["", f"Failed tests ({len(ev['failures'])}):"]
        for f in ev["failures"]:
            lines += ["", f"- {f['name']}", f"  {f['message']}"]
            if f["stackTrace"]:
                lines += ["  " + l for l in f["stackTrace"].splitlines()]
    if ev["lowCoverage"]:
        lines += ["", f"Classes below {COVERAGE_TARGET:.0f}% coverage ({len(ev['lowCoverage'])}):"]
        for c in ev["lowCoverage"]:
            lines.append(f"  {c['percent']:5.0f}%  {c['name']}")
    return "\n".join(lines) + "\n"


def build_html(ev):
    e = html.escape
    color = "#1a7f37" if ev["ok"] else "#cf222e"
    status = "All tests passed" if ev["ok"] else ("Tests failed" if ev["failing"] else "Run problem")
    cov = ev["orgWideCoverage"]
    cov_color = "#1a7f37" if cov is not None and cov >= COVERAGE_TARGET else "#cf222e"
    td = 'style="padding:4px 12px 4px 0;border-bottom:1px solid #eee;vertical-align:top"'

    parts = [
        '<div style="font-family:Segoe UI,Arial,sans-serif;font-size:14px;color:#1f2328;max-width:900px">',
        f'<h2 style="color:{color};margin:0 0 12px">{e(status)}</h2>',
        '<table style="border-collapse:collapse;margin-bottom:16px">',
        f"<tr><td {td}>Tests ran</td><td {td}><b>{ev['testsRan']}</b></td></tr>",
        f"<tr><td {td}>Passed</td><td {td}>{ev['passing']}</td></tr>",
        f"<tr><td {td}>Failed</td><td {td}><b style=\"color:{color}\">{ev['failing']}</b></td></tr>",
        f"<tr><td {td}>Skipped</td><td {td}>{ev['skipped']}</td></tr>",
        f"<tr><td {td}>Org-wide coverage</td><td {td}><b style=\"color:{cov_color}\">{fmt_pct(cov)}</b>"
        f" (target {COVERAGE_TARGET:.0f}%)</td></tr>",
        f"<tr><td {td}>Test run ID</td><td {td}>{e(ev['testRunId'] or 'n/a')}</td></tr>",
        "</table>",
    ]
    if ev["error"]:
        parts.append(f'<p style="color:#cf222e"><b>Problem:</b> {e(ev["error"])}</p>')
    if ev["failures"]:
        parts.append(f"<h3>Failed tests ({len(ev['failures'])})</h3>")
        parts.append('<table style="border-collapse:collapse;width:100%">')
        parts.append(f"<tr><th align=left {td}>Test</th><th align=left {td}>Error</th></tr>")
        for f in ev["failures"]:
            trace = f"<pre style=\"margin:4px 0 0;font-size:12px;color:#57606a;white-space:pre-wrap\">{e(f['stackTrace'])}</pre>" if f["stackTrace"] else ""
            parts.append(f"<tr><td {td}><code>{e(f['name'])}</code></td><td {td}>{e(f['message'])}{trace}</td></tr>")
        parts.append("</table>")
    if ev["lowCoverage"]:
        shown = ev["lowCoverage"][:LOW_COVERAGE_LIMIT]
        parts.append(f"<h3>Classes below {COVERAGE_TARGET:.0f}% coverage ({len(ev['lowCoverage'])})</h3>")
        parts.append('<table style="border-collapse:collapse">')
        for c in shown:
            parts.append(f"<tr><td {td} align=right>{c['percent']:.0f}%</td><td {td}><code>{e(c['name'] or '')}</code></td></tr>")
        parts.append("</table>")
        if len(ev["lowCoverage"]) > len(shown):
            parts.append(f"<p>…and {len(ev['lowCoverage']) - len(shown)} more in the attached report.</p>")
    parts.append("</div>")
    return "\n".join(parts)


def main():
    if len(sys.argv) != 2:
        print(__doc__)
        return 2
    report_dir = Path(sys.argv[1])
    report_dir.mkdir(parents=True, exist_ok=True)

    data, error = load_result(report_dir / "apex-test-result.json")
    ev = evaluate(data, error)

    (report_dir / "apex-test-evaluation.json").write_text(json.dumps(ev, indent=2), encoding="utf-8")
    (report_dir / "apex-test-report.txt").write_text(build_text(ev), encoding="utf-8")
    (report_dir / "apex-test-report.html").write_text(build_html(ev), encoding="utf-8")

    print(
        f"outcome={ev['outcome']} ran={ev['testsRan']} failed={ev['failing']} "
        f"coverage={fmt_pct(ev['orgWideCoverage'])}" + (f" problem={ev['error']}" if ev["error"] else "")
    )
    return 0 if ev["ok"] else 1


if __name__ == "__main__":
    sys.exit(main())
