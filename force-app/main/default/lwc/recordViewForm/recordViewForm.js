import { LightningElement ,api } from 'lwc';
import ACCOUNT_OBJECT from '@salesforce/schema/Demo__c';
import NAME_FIELD from '@salesforce/schema/Demo__c.Name__c';
import Email_FIELD from '@salesforce/schema/Account.Email__c';
import Phone_FIELD from '@salesforce/schema/Demo__c.Phone_No__c';
import Owner_FIELD from '@salesforce/schema/Demo__c.OwnerId';

export default class RecordViewForm extends LightningElement {
    nameField=NAME_FIELD;
    emailField=Email_FIELD;
    phoneField=Phone_FIELD;
    ownerField=Owner_FIELD;
    objectApiName=ACCOUNT_OBJECT

    @api recordId="01I5j000001mZCP";
}