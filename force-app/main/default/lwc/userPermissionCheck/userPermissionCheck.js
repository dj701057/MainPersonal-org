import { LightningElement } from 'lwc';
import hasRunReport from '@salesforce/userPermission/RunReports';
export default class UserPermissionCheck extends LightningElement {
    get isRunReport(){
        return hasRunReport;
    }
}