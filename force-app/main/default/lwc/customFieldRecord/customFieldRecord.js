import { LightningElement, api, wire } from 'lwc';
import getCustomField from '@salesforce/apex/AccountCustomController.getCustomField';

export default class CustomFieldRecord extends LightningElement {
    @api recordId;

    customField;

    connectedCallback() {
        getCustomField({ accountId: this.recordId })
            .then(result => {
                this.customField = result;
            })
            .catch(error => {
                console.error(error);
            });
    }
}





/*import { LightningElement, api, wire } from 'lwc';
import getCustomField from '@salesforce/apex/AccountCustomController.getCustomField';

export default class CustomFieldRecord extends LightningElement {
    @api recordId;

    @wire(getCustomField, { recordId: '$recordId' })
    customField;

    connectedCallback() {
        if (!this.recordId) {
            console.error('No recordId provided.');
        }
    }
}
import { LightningElement, api, wire } from 'lwc';
import getCustomField from '@salesforce/apex/AccountCustomController.getCustomField';

export default class CustomFieldRecord extends LightningElement {
    @api recordId;

    @wire(getCustomField, {accountId: '$recordId'})
    customField;

    get hasCustomField() {
        return this.customField && this.customField.data;
    }
}*/