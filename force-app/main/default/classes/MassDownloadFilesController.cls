public with sharing class MassDownloadFilesController {
    
    @AuraEnabled( cacheable = true )
    public static List < FilesWrapper > fetchRelatedFiles(Id strRecordId) {
        List < FilesWrapper > listFilesWrapper = new List < FilesWrapper >();
        for ( ContentDocumentLink objCDL: [SELECT ContentDocument.LatestPublishedVersionId,ContentDocument.Title FROM ContentDocumentLink WHERE LinkedEntityId =: strRecordId  ] )
        {
            listFilesWrapper.add(new FilesWrapper(objCDL.ContentDocument.LatestPublishedVersionId,objCDL.ContentDocument.Title ) );
        }
        return listFilesWrapper;  
    }
    
    public class FilesWrapper {
        
        @AuraEnabled
        public Id documentId;
        @AuraEnabled
        public String documentName;
        
        public FilesWrapper( Id documentId, String documentName) 
        { 
            this.documentId = documentId;
            this.documentName = documentName;
            
        }
        
    }
    
}