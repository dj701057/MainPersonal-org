//ProgressBarExample.js
import { LightningElement } from 'lwc';

export default class progressBar extends LightningElement() {

    progress = 0;
    emailAddress = '';
    mobile = '';
    birthdate = '';
    firstName = '';
    lastName = '';

    handleChange(event) {
    const field = event.target.name;
        if (field === 'firstName') {
            this.firstName = event.target.value;
        } 
        else if (field === 'lastName') {
            this.lastName = event.target.value;
        }
        else if (field === 'mobile') {
            this.mobile = event.target.value;
        }
        else if (field === 'emailAddress') {
            this.emailAddress = event.target.value;
        }
        else if (field === 'birthdate') {
            this.birthdate = event.target.value;
        }
        this.fieldsCompleted();
    }

    fieldsCompleted() {
        var numVal = 0;

        if (this.firstName != null && this.firstName != '') {
            numVal = numVal + 1;
        }

        if (this.lastName != null && this.lastName != '') {
            numVal = numVal + 1;
        }

        if (this.birthdate != null && this.birthdate != '') {
            numVal = numVal + 1;
        }

        if (this.emailAddress != null && this.emailAddress !='') {
            numVal = numVal + 1;
        }
        
        if (this.mobile != null && this.mobile !='') {
            numVal = numVal + 1;
        }

        this.progressBar(numVal);
    }

    progressBar(numVal) {
        if (numVal >= 1) {
            this.progress = numVal * 20;
        }
        else {
            this.progress = 0;
        }
    }

    handleSubmit() {
    }

    handleReset() {
        this.progress = 0;
        this.emailAddress = '';
        this.mobile = '';
        this.birthdate = '';
        this.firstName = '';
        this.lastName = '';
    }
}