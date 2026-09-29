import { LightningElement, track } from 'lwc';
import { loadScript, loadStyle } from 'lightning/platformResourceLoader';
import signaturePadLib from '@salesforce/resourceUrl/signature_pad';
import jsPDFLib from '@salesforce/resourceUrl/jsPDF';

export default class SignAndOverlayPDF extends LightningElement {
    @track signaturePad;
    @track pdfDocument;

    async connectedCallback() {
        await Promise.all([
            loadScript(this, signaturePadLib),
            loadScript(this, jsPDFLib),
            loadStyle(this, signaturePadLib + '/signature-pad.css')
        ]);

        const canvas = this.template.querySelector('#signatureCanvas');
        this.signaturePad = new SignaturePad(canvas);
    }

    signPDF() {
        if (this.signaturePad) {
            // Capture signature
            const signatureData = this.signaturePad.toDataURL();

            // Create PDF document
            this.pdfDocument = new jsPDF();
            this.pdfDocument.text(20, 20, 'Signed by:');
            this.pdfDocument.addImage(signatureData, 'PNG', 20, 30, 50, 20);
        }
    }

    downloadPDF() {
        if (this.pdfDocument) {
            const pdfDataUri = this.pdfDocument.output('datauri');
            const link = document.createElement('a');
            link.href = pdfDataUri;
            link.download = 'signed_document.pdf';
            link.click();
        }
    }
}