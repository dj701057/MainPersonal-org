import { LightningElement, api, track } from 'lwc';
import saveSignature from '@salesforce/apex/SignatureCtrl.saveSignature';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { RefreshEvent } from 'lightning/refresh';
let saveType = 'SFFile'; //'SFFile' 'Attachment'
let sCanvas, context; //canvas and it context 2d
let mDown = false;
let currPos = { x: 0, y: 0 };
let prePos = { x: 0, y: 0 };

export default class SignAndCaptureLWC extends LightningElement {
    @track isSignOnPDFModalOpen = false;
    @track isCaptureSignModalOpen = false;

    openSignOnPDFModal() {
        this.isSignOnPDFModalOpen = true;
    }

    openCaptureSignModal() {
        this.isCaptureSignModalOpen = true;
    }

    closeModal() {
        this.isSignOnPDFModalOpen = false;
        this.isCaptureSignModalOpen = false;
    }
    @api recordId;
    showLoading = false;

    constructor() {
        super();
        //mouse Events
        this.template.addEventListener('mousedown', this.handleMousedown.bind(this));
        this.template.addEventListener('mouseup', this.handleMouseup.bind(this));
        this.template.addEventListener('mousemove', this.handleMousemove.bind(this));
        this.template.addEventListener('mouseout', this.handleMouseend.bind(this));
    }

    renderedCallback() {
        sCanvas = this.template.querySelector('canvas');
        context = sCanvas.getContext('2d');
    }

    handleMousedown(evt) {
        evt.preventDefault();
        mDown = true;
        this.getPos(evt);
    }

    handleSaveSignature(evt) {
        this.showLoading = true;
        context.globalCompositeOperation = "destination-over";
        context.fillStyle = "#FFF";
        context.fillRect(0, 0, sCanvas.width, sCanvas.height);

        let imageURL = sCanvas.toDataURL('image/png');
        let imageData = imageURL.replace(/^data:image\/(png|jpg);base64,/, "");
        console.log(this.recordId);
        saveSignature({ relatedId: this.recordId, data: imageData, type: saveType })
            .then(result => {
                this.showToast('Signature Captured!!', 'The signature has been saved!!', 'success', 'dismissable');
                this.handleClear();
                this.handleRefresh();
                this.showLoading = false;
            })
            .catch(error => {
                this.showToast('Error!!', error.body.message, 'error', 'dismissable');
                this.showLoading = false;
            })
    }

    handleMouseup(evt) {
        evt.preventDefault();
        mDown = false;
    }

    handleMousemove(evt) {
        evt.preventDefault();
        if (mDown) {
            this.getPos(evt);
            this.draw();
        }
    }

    getPos(evt) {
        let cRect = sCanvas.getBoundingClientRect();
        prePos = currPos;
        currPos = { x: (evt.clientX - cRect.left), y: (evt.clientY - cRect.top) };
    }

    handleMouseend(evt) {
        evt.preventDefault();
        mDown = false;
    }

    draw() {
        context.beginPath();
        context.moveTo(prePos.x, prePos.y);
        context.lineCap = 'round';//smooth line
        context.lineWidth = 1.5;
        context.strokeStyle = "#0000FF";//blue
        context.lineTo(currPos.x, currPos.y);
        context.closePath();
        context.stroke();
    }

    handleClear() {
        context.clearRect(0, 0, sCanvas.width, sCanvas.height);
    }

    handleRefresh() {
        // refresh the standard related list
        this.dispatchEvent(new RefreshEvent());
    }

    showToast(title, message, variant, mode) {
        const evt = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
            mode: mode
        });
        this.dispatchEvent(evt);
    }
}