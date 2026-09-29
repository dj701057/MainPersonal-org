public with sharing class searchFileHandler {
    @AuraEnabled(cacheable = true)
    public static List<ContentDocument> getFileOwned(String userId){
          return [SELECT FileExtension,FileType,Title,Owner.Name,LastModifiedDate
                   FROM ContentDocument ORDER BY LastModifiedDate desc];

    }
}