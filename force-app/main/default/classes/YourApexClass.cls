public with sharing class YourApexClass {
    @AuraEnabled(cacheable=true)
    public static List<SObject> fetchSalesforceData(String searchKey) {
        // Implement SOQL query to fetch Salesforce records based on searchKey
        return [SELECT Id, Name FROM Account WHERE Name LIKE :searchKey];
    }

    @AuraEnabled(cacheable=true)
    public static List<SObject> fetchComData(String searchKey) {
        // Implement logic to fetch data from COM API based on searchKey
        return [SELECT Id, Name FROM Account WHERE Name LIKE :searchKey];
    }
}