import { LightningElement } from 'lwc';

export default class LightningInputAnimination extends LightningElement {
    oldDate ='';
    oldDate2 ='';

    handleChangeAction(event){
        if(event.target.name == 'oldDate'){
            this.oldDate = event.target.value;
        }
        if(event.target.name == 'oldDate2'){
            this.oldDate2 = event.target.value;
        }
    }
}