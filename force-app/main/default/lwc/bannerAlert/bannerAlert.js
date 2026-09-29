import { LightningElement, wire } from 'lwc';
import getBannerNotification from '@salesforce/apex/BannerNotification.getBannerNotification';

export default class BannerAlert extends LightningElement {

    @wire(getBannerNotification) banner;

    get message() {
        return this.banner.data.Message__c;
    }

    maintenanceStartDate() {
        return this.banner && this.banner.data ? this.banner.data.Maintenance_Start_Date__c : 'Loading...';
    }

    maintenanceEndDate() {
        return this.banner && this.banner.data ? this.banner.data.Maintenance_End_Date__c : 'Loading...';
    }

    get expression() {

        let today = new Date();
        today.setMinutes(new Date().getMinutes() - new Date().getTimezoneOffset());
        
        // Return today's date in "YYYY-MM-DD" format
        let date = today.toISOString().slice(0,10); 

        let plannedMaintenanceStartDate = this.maintenanceStartDate();
        let plannedMaintenanceEndDate = this.maintenanceEndDate();

        if (date >= plannedMaintenanceStartDate && date <= plannedMaintenanceEndDate) {
            return true;
        }
        else {
            return false;
        }
    }
}