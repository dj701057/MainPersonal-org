import { LightningElement, track, wire, api} from 'lwc';
import sendEmailController from "@salesforce/apex/emailClass2.sendEmailController";
import getMergeFieldValue from "@salesforce/apex/emailClass2.getMergeFieldValue";
import getObjects from '@salesforce/apex/FieldExplorerController2.getObjects';
import getFields from '@salesforce/apex/FieldExplorerController2.getFields';

export default class emailLwc2 extends LightningElement {

    toAddress = [];
    ccAddress = [];
    subject = "";
    body = "";
    @track files = [];
    
    wantToUploadFile = false;
 
    wantToInsertField= false;
    noEmailError = false;
    invalidEmails = false;

    toggleFileUpload() {
        this.wantToUploadFile = !this.wantToUploadFile;
    }

    toggleIsertField() {
        this.wantToInsertField = !this.wantToInsertField;
    }

    handleUploadFinished(event) {
        const uploadedFiles = event.detail.files;
        this.files = [...this.files, ...uploadedFiles];
        this.wantToUploadFile = false;
    }

    handleRemove(event) {
        const index = event.target.dataset.index;
        this.files.splice(index, 1);
    }

    handleToAddressChange(event) {
        this.toAddress = event.detail.selectedValues;
    }

    handleCcAddressChange(event) {
        this.ccAddress = event.detail.selectedValues;
    }

    handleSubjectChange(event) {
        this.subject = event.target.value;
    }

    handleBodyChange(event) {
        this.body = event.target.value;
    }
    hideModalBox() {  
        this.wantToInsertField = false;
    }
    validateEmails(emailAddressList) {
        let areEmailsValid;
        if(emailAddressList.length > 1) {
            areEmailsValid = emailAddressList.reduce((accumulator, next) => {
                const isValid = this.validateEmail(next);
                return accumulator && isValid;
            });
        }
        else if(emailAddressList.length > 0) {
            areEmailsValid = this.validateEmail(emailAddressList[0]);
        }
        return areEmailsValid;
    }

    validateEmail(email) {
        console.log("In VE");
        const res = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()s[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        console.log("res", res);
        return res.test(String(email).toLowerCase());
    }

    handleReset() {
        this.toAddress = [];
        this.ccAddress = [];
        this.subject = "";
        this.body = "";
        this.files = [];
        this.template.querySelectorAll("c-email-input").forEach((input) => input.reset());
    }

    handleSendEmail() {
        this.noEmailError = false;
        this.invalidEmails = false;
        if (![...this.toAddress, ...this.ccAddress].length > 0) {
            this.noEmailError = true;
            return;
        }
        
        if (!this.validateEmails([...this.toAddress, ...this.ccAddress])) {
            this.invalidEmails = true;
            return;
        }

        let emailDetails = {
            toAddress: this.toAddress,
            ccAddress: this.ccAddress,
            subject: this.subject,
            body: this.body
        };

        sendEmailController({ emailDetailStr: JSON.stringify(emailDetails) })
            .then(() => {
                console.log("Email Sent");
            })
            .catch((error) => {
                console.error("Error in sedig mail", error);
            });
    }
    openModal() {
        //     // to open modal set isModalOpen tarck value as true
            this.wantToInsertField = true;
    }
    closeModal() {
            // to close modal set isModalOpen tarck value as false
        this.wantToInsertField = false;
    }
    submitDetails(event) {
            // to close modal set isModalOpen tarck value as false
            //Add your code to call apex method or do some processing
        this.wantToInsertField = false;
       // this.body = this.body + '{{{'+ this.selectedObject + '.' + this.selectedfield + '}}}';
        console.log(this.body);
        let mergeFieldDetail = {
            selectedfield : this.selectedfield,
            selectedObject : this.selectedObject,
            toAddress: this.toAddress
        }; 
        getMergeFieldValue({ mergeFieldDetailStr: JSON.stringify(mergeFieldDetail) })
        .then((result) => {
            console.log("get value");
            this.strigVal=result;
            console.log(this.strigVal);
        
            let val=this.strigVal[Object.keys(this.strigVal)[0]]; 
            console.log(val);

            var fieldVal = Object.values(val)[0];
            console.log(fieldVal);
            this.body = this.body + fieldVal;
        })
        .catch((error) => {
            console.error("Error in getting value", error);
        }); 
        
    }

    @track objects = [];
    @track fields = [];
    @wire(getObjects)
    wiredMethod({ error, data }) {
        if (data) {
            this.dataArray = data;
            let tempArray = [];
            this.dataArray.forEach(function (element) {
                var option=
                {
                    label:element,
                    value:element
                };
                tempArray.push(option);
            });
            this.objects=tempArray;
        } else if (error) {
            this.error = error;
        }
    } 
    
    handleObjectChange(event)
    {   
        const selectedOption = event.detail.value;  
        getFields({ objectName: selectedOption})
        .then(result => {
            this.dataArray = result;
            let tempArray = [];
            this.dataArray.forEach(function (element) {
                var option=
                {
                    label:element.Label,
                    value:element.Name
                };
                tempArray.push(option);
            });
            this.fields=tempArray;
            this.selectedObject= event.detail.value; 
            console.log(this.selectedObject);

        })
        .catch(error => {
            this.error = error;
        });

    }
    handleFieldChange(event){
        this.selectedfield= event.detail.value; 
        
        console.log(this.selectedfield);

    }
}