public with sharing class AccountCustomController {
    @AuraEnabled(cacheable=true)
    public static String getCustomField(String accountId) {
        Account acc = [SELECT Custom_Field__c FROM Account WHERE Id=:accountId];
        return acc.Custom_Field__c;
    }
}












/*public class AccountCustomController {
    @AuraEnabled(cacheable=true)
    public static String getCustomField(String recordId) {
        String customFieldValue = '';
        try {
            customFieldValue = [SELECT Custom_Field__c FROM Account WHERE Id = :recordId].Custom_Field__c;
        } catch(Exception e) {
            System.debug('Error retrieving custom field value: ' + e.getMessage());
        }
        return customFieldValue;
    }
}
public with sharing class AccountCustomController {
    @AuraEnabled(cacheable=true)
    public static String getCustomField(String accountId) {
        Account acc = [SELECT Custom_Field__c FROM Account WHERE Id=:accountId];
        return acc.Custom_Field__c;
    }
}*/