public with sharing class BannerNotification {
    @AuraEnabled(cacheable=true)  

    public static Maintenence_Notification__mdt getBannerNotification() {
        return [
            SELECT Id, Maintenence_end_date__c, 	
            Maintenence_start_date__c , Message__c 
            FROM Maintenence_Notification__mdt where DeveloperName ='Salesforce_Release' 
            LIMIT 1
        ];
    }
}