import { LightningElement, track } from 'lwc';

export default class LwcCustomRadioButton extends LightningElement {
    value = 'Salesforce LWC';
 
    get options() {
        return [
            { label: 'Salesforce LWC', value: 'Salesforce LWC' },
            { label: 'LWC RecordList', value: 'LWC RecordList' },
            { label: 'Tutorial', value: 'Tutorial' },
            { label: 'Tech Guide', value: 'Tech Guide' },
            { label: 'Blog', value: 'Blog' },
            { label: 'Aura Component', value: 'Aura Component' },
            
        ];
    }
    @track salesforceLwcFieldValue = true;
    @track tutorialFieldValue = false;
    @track techGuideFieldValue = false;
    @track blogFieldValue = false; 
    @track auraCompFieldValue = false;
    @track LwcRecordList =false;
    
 
    handleRadioChange(event) {
        const selectedOption = event.detail.value;
        //alert('selectedOption ' + selectedOption);
        if (selectedOption == 'Salesforce LWC'){
            this.salesforceLwcFieldValue = true;
        }
        else{
            this.salesforceLwcFieldValue = false;
        }
        if (selectedOption == 'LWC RecordList'){
            this.LwcRecordList = true;
        }
        else{
            this.salesforceLwcFieldValue = false;
        }

        if (selectedOption == 'Tutorial'){
            this.tutorialFieldValue = true;
        }else{
            this.tutorialFieldValue = false;
        }
        
 
        if (selectedOption == 'Tech Guide'){
            this.techGuideFieldValue = true;
        }else{
            this.techGuideFieldValue = false;
        }

        if (selectedOption == 'Blog'){
            this.blogFieldValue = true;
        }else{
            this.blogFieldValue = false;
        }
        
 
      if (selectedOption == 'Aura Component'){
            this.auraCompFieldValue = true;
        }
        else{
            this.auraCompFieldValue = false;
        }
        
    }
}