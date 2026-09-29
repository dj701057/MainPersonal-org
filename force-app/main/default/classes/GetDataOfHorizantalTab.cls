public with sharing class GetDataOfHorizantalTab {
    public static List<ApexClass> GetAllLwcRecords(){
        try {
            return [SELECT Id, NamespacePrefix, Name, ApiVersion, Status, IsValid, BodyCrc, Body, LengthWithoutComments, CreatedDate, CreatedBy.Name, LastModifiedDate, LastModifiedBy.Name, SystemModstamp FROM ApexClass];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        
    }
}