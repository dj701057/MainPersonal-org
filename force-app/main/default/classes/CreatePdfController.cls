public with sharing class CreatePdfController {
    
    @AuraEnabled
    public static Id generatePdf(String idAccount){
        Blob strPdfBody = null;
        Attachment objAttach = new Attachment();
        try {
            Account objAccount = [SELECT Name FROM Account WHERE Id = :idAccount LIMIT 1];
            PageReference objPagePdf = Page.PdfTemplate;
            objPagePdf.getParameters().put('Id', idAccount);
            strPdfBody =  objPagePdf.getContent();

            ContentVersion objVersion = new ContentVersion();
            objVersion.ContentLocation = 'S';
            objVersion.PathOnClient = 'Test ' +objAccount.Name +'.pdf';
            objVersion.Title = 'Test ' +objAccount.Name;
            objVersion.VersionData = strPdfBody;
            insert objVersion;

            Id objDocId = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:objVersion.Id].ContentDocumentId;
            ContentDocumentLink objDocumentLink = New ContentDocumentLink();
            objDocumentLink.LinkedEntityId = objAccount.Id;
            objDocumentLink.ContentDocumentId = objDocId;
            objDocumentLink.shareType = 'V';
            insert objDocumentLink;
            return objDocumentLink.Id;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}