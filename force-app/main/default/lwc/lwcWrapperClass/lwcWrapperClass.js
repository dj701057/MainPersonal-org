import { LightningElement ,wire} from 'lwc';
import fetchOppData from '@salesforce/apex/lwcWrapperClassCtrl.fetchOppData';
export default class LwcWrapperClass extends LightningElement {
    @wire(fetchOppData) oppData;
}