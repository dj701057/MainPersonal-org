import { LightningElement } from 'lwc';

export default class QuizComponent extends LightningElement {
    optionA = 'A - Programming Language';
    optionB = 'B - HTML & CSS';
    optionC = 'C - JavaScript';
    optionD = 'D - Salesforce Apex';

    selectOptionA() {
        this.saveSelectedOption(this.optionA);
    }

    selectOptionB() {
        this.saveSelectedOption(this.optionB);
    }

    selectOptionC() {
        this.saveSelectedOption(this.optionC);
    }

    selectOptionD() {
        this.saveSelectedOption(this.optionD);
    }

    saveSelectedOption(option) {
        // Perform the necessary logic to save the selected option to Salesforce object
        console.log(option);
        // Rest of the code
    }
}