import { LightningElement } from 'lwc';

import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';
import REVENUE_FIELD from '@salesforce/schema/Account.AnnualRevenue';

import CONTACT_FIELD from '@salesforce/schema/Contact';
import conFirstName from '@salesforce/schema/Contact.FirstName';
import conLastName from '@salesforce/schema/Contact.LastName';
import conEmail from '@salesforce/schema/Contact.Email';

export default class RecordForm extends LightningElement {
    objectApiName=ACCOUNT_OBJECT;
    fields = [NAME_FIELD,PHONE_FIELD,REVENUE_FIELD];
    objectContact=CONTACT_FIELD;
    fields2 =[conFirstName,conLastName, conEmail];

    handleSuccess(event){
        const toastEvent=new ShowToastEvent({
            title:"Account has been created successfully !",
            message: "Account Created ",
            variant: "success"
        });
        this.dispatchEvent(toastEvent);

       
    }
}