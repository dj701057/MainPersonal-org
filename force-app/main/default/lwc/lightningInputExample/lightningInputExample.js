import { LightningElement } from 'lwc';

export default class LightningInputExample extends LightningElement {
    emailvalue='abc@gmail.com';
    MobileNumber='**********';
    handleEmailChange(event){
        this.emailvalue =event.target.value;
    }
    handleMobileNumberChange(event){
        this.MobileNumber = event.target.value;
    }
    handleNext() {

        alert('email '+ this.emailvalue);
        alert('Mobile '+ this.MobileNumber);
        
    }
    handleCancel(){
        this.emailvalue='abc@gmail.com';
        this.MobileNumber='**********';
    }
}