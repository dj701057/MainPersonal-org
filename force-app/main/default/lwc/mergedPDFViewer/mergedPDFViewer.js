import { LightningElement, api, wire } from 'lwc';
import getPdfFilesWithIdsAsBase64 from '@salesforce/apex/QuoteFileService.getPdfFilesWithIdsAsBase64';
import pdfLib from '@salesforce/resourceUrl/PdfLib';
import { loadScript } from 'lightning/platformResourceLoader';
import saveMergedPdf from '@salesforce/apex/QuoteFileService.saveMergedPdf';
import sendEmailWithPdf from '@salesforce/apex/QuoteFileService.sendEmailWithPdf';

export default class MergedPDFViewer extends LightningElement {
    @api recordId;
    isLibLoaded = false;
    mergedPdfUrl;
    pdfLibInstance;

    renderedCallback() {
        console.log('renderedCallback called');  // Debug: Callback triggered
        if (this.isLibLoaded) {
            console.log('Library already loaded. Skipping load.');  
            return;
        }

        console.log('Loading PDF-lib resource...');  
        loadScript(this, pdfLib + '/pdfLib/pdf-lib.min.js')
            .then(() => {
                console.log('PDF-lib resource loaded successfully');  
                if (window['pdfLib'] || window['PDFLib']) {
                    console.log('pdfLib instance found.');  
                    this.isLibLoaded = true;
                    this.pdfLibInstance = window['pdfLib'] || window['PDFLib'];
                    this.loadPdfs();  // Trigger PDF load after lib is ready
                } else {
                    console.error('PDF-LIB not loaded correctly.');  
                }
            })
            .catch(error => {
                console.error('Error loading PDF-LIB:', error);  
            });
    }

    @wire(getPdfFilesWithIdsAsBase64, { opportunityId: '$recordId' })
    wiredPdfs({ error, data }) {
        if (this.isLibLoaded) {
            if (data) {
                console.log('Fetched PDF data:', data);  
                this.mergePDFs(data);
            } else {
                console.warn('No PDF data received.');  
            }
        } else if (error) {
            console.error('Error fetching PDFs:', error);  
        }
    }

    async mergePDFs(pdfFiles) {
        console.log('Starting to merge PDFs...');  
        if (!this.pdfLibInstance) {
            console.error('PDF-LIB instance is not defined.');  
            return;
        }

        const { PDFDocument } = this.pdfLibInstance;
        const mergedPdf = await PDFDocument.create();
        for (let pdfFile of pdfFiles) {
            console.log(`Processing PDF file with ID: ${pdfFile.Id}`);  
            const pdfBytes = Uint8Array.from(atob(pdfFile.Base64Data), c => c.charCodeAt(0));
            const pdfDoc = await PDFDocument.load(pdfBytes);
            const copiedPages = await mergedPdf.copyPages(pdfDoc, pdfDoc.getPageIndices());
            copiedPages.forEach(page => mergedPdf.addPage(page));
        }

        const mergedPdfBytes = await mergedPdf.save();
        this.mergedPdfUrl = URL.createObjectURL(new Blob([mergedPdfBytes], { type: 'application/pdf' }));
        console.log('Merged PDF URL created:', this.mergedPdfUrl);  
    }

    async mergePDFs(pdfFiles) {
    console.log('Starting to merge PDFs...');
    const { PDFDocument } = this.pdfLibInstance;
    const mergedPdf = await PDFDocument.create();
    for (let pdfFile of pdfFiles) {
        const pdfBytes = Uint8Array.from(atob(pdfFile.Base64Data), c => c.charCodeAt(0));
        const pdfDoc = await PDFDocument.load(pdfBytes);
        const copiedPages = await mergedPdf.copyPages(pdfDoc, pdfDoc.getPageIndices());
        copiedPages.forEach(page => mergedPdf.addPage(page));
    }

    const mergedPdfBytes = await mergedPdf.save();
    const base64Pdf = btoa(
        new Uint8Array(mergedPdfBytes)
            .reduce((data, byte) => data + String.fromCharCode(byte), '')
    );

    // Create a URL for the merged PDF
    this.mergedPdfUrl = URL.createObjectURL(new Blob([mergedPdfBytes], { type: 'application/pdf' }));

    console.log('Merged PDF URL created:', this.mergedPdfUrl);

    // Save the merged PDF to Salesforce
    try {
        const fileName = `MergedPDF_${this.recordId}.pdf`;
        await saveMergedPdf({ opportunityId: this.recordId, base64Pdf, fileName });
        console.log('Merged PDF saved to Salesforce successfully.');

        // Send email with the merged PDF
        const emailAddress = 'example@domain.com'; // Replace with Opportunity-related email address
        await sendEmailWithPdf({ opportunityId: this.recordId, base64Pdf, fileName, emailAddress });
        console.log('Email sent successfully with the merged PDF.');
    } catch (error) {
        console.error('Error saving or emailing the merged PDF:', error);
    }
}
}