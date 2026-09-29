public with sharing class SearchaApexClassExplorerController {
    @AuraEnabled
    public static List<ApexClass> fetchApexClass(String searchKey){
        String key = '%' + searchKey + '%';
        try {
            return [SELECT Id, NamespacePrefix, Name, ApiVersion, Status, IsValid, BodyCrc, Body, LengthWithoutComments, CreatedDate, CreatedBy.Name, LastModifiedDate, LastModifiedBy.Name, SystemModstamp FROM ApexClass WHERE Name LIKE :key];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}