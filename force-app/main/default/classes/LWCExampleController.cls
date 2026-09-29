public inherited sharing class LWCExampleController {
    
    @AuraEnabled
    public static ContentVersion saveFile(Id idParent, String strFileName, String base64Data) {
        // Decoding base64Data
        base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
        
        // inserting file
        ContentVersion cv = new ContentVersion();
        cv.Title = strFileName;
        cv.PathOnClient = '/' + strFileName;
        cv.FirstPublishLocationId = idParent;
        cv.VersionData = EncodingUtil.base64Decode(base64Data);
        cv.IsMajorVersion = true;
        Insert cv;
        return cv;
    }

    @AuraEnabled
    public static list<contentversion> releatedFiles(Id idParent ,String searchKey){
        string searchKeyword = '%' + searchKey +'%';

        /*list<id> lstConDocs = new list<id>();*/
        /*for(ContentDocumentLink cntLink : [Select Id, ContentDocumentId ,name From ContentDocumentLink Where  LinkedEntityId != null AND name LIKE : searchKeyword]) {
            lstConDocs.add(cntLink.ContentDocumentId);
        }*/
         
            return [SELECT Id, Title, ContentDocumentId FROM ContentVersion WHERE Title LIKE :searchKeyword];
        
        
    }
}