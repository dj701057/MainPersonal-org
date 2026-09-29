import { LightningElement, track ,wire} from "lwc";
import sendEmailController from "@salesforce/apex/EmailClass.sendEmailController";
import getContactFields from '@salesforce/apex/ExploreCustomContactController.getContactFields';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import CONTACT_OBJECT from '@salesforce/schema/Contact';
import Type_FIELD from '@salesforce/schema/Contact.LeadSource';

export default class EmailLwc extends LightningElement {
    toAddress = [];
    ccAddress = [];
    subject = "";
    body = "";
    @track files = [];
    @track isShowModal = false;
    @wire(getContactFields) wiredContactFields;
    @track selectedValue;
    @track options = [];
    @track chooseOptionName = 'Recipient';
    @track contactRecip =[];
   
    wantToUploadFile = false;
    noEmailError = false;
    invalidEmails = false;

    MergeHandler(){
        this.isShowModal = true;
    }
    hideModalBox() {  
        this.isShowModal = false;
    }

    toggleFileUpload() {
        this.wantToUploadFile = !this.wantToUploadFile;
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
                console.error("Error in sendEmailController:", error);
            });
    }
    //radio
    @wire(getObjectInfo, { objectApiName: CONTACT_OBJECT })
    objectInfo;
    @wire(getPicklistValues, { recordTypeId: '$objectInfo.data.defaultRecordTypeId', fieldApiName: Type_FIELD})
    typePicklistValues({error, data}) {
        if(data) {
            let optionsValues = [];
            for(let i = 0; i < data.values.length; i++) {
                optionsValues.push({
                    label: data.values[i].label,
                    value: data.values[i].value
                })
            }
            this.options = optionsValues;
            window.console.log('optionsValues ===> '+JSON.stringify(optionsValues));
        }
        else if(error) {
            window.console.log('error ===> '+JSON.stringify(error));
        }
    }

    // handle the selected value
    handleChange(event) {
        this.selectedValue = event.detail.value;
    }
    handleOptionClick(event){
        this.chooseOptionName = event.target.text;
        console.log(this.chooseOptionName);
        if(this.chooseOptionName.includes("Recipient")){
            this.getContactField();
        }
    }
    getContactField(){
        getContactFields({userId : this.userId})
               .then(result => {
                   if(result.length >0){
                   const contectList = result;
                   this.sizeofOptionList = result.length;
                   console.log('This is Option List size ',this.sizeofOptionList);
                   let Recipients;
                   let titleUrl;
                   this.contactRecip = contectList.map(row => {
                    titleUrl = `/${row.Id}`;
                    Recipients = row.Recipient;
                    return {...row,titleUrl,Recipients}
                   });
                   console.log('ContactList------>',contectList);

                   console.log(this.contactRecip);
                   }
               })
               .catch(error => {
                console.log(error);
                this.contactRecip = []; 
            });
    }
}