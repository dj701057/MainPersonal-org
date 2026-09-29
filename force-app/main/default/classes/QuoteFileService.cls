public class QuoteFileService {
    @AuraEnabled(cacheable=true)
    public static List<Map<String, String>> getPdfFilesWithIdsAsBase64(Id opportunityId) {
        // List of statuses in the required order
        List<String> statusOrder = new List<String>{'Accepted','Denied','Rejected','Approved','In Review','Needs Review','Draft'};
            
            // Find all quotes related to the given opportunity
            List<Quote> quotes = [SELECT Id, Status FROM Quote WHERE OpportunityId = :opportunityId];
        
        // Collect all quote IDs
        Set<Id> quoteIds = new Set<Id>();
        Map<Id, String> quoteStatusMap = new Map<Id, String>();
        for (Quote quote : quotes) {
            quoteIds.add(quote.Id);
            quoteStatusMap.put(quote.Id, quote.Status);
        }
        
        // Find all content document links related to the quotes
        List<ContentDocumentLink> contentDocumentLinks = [
            SELECT ContentDocumentId, LinkedEntityId
            FROM ContentDocumentLink
            WHERE LinkedEntityId IN :quoteIds
        ];
        
        // Collect all content document IDs from the links
        Set<Id> contentDocumentIds = new Set<Id>();
        for (ContentDocumentLink cdl : contentDocumentLinks) {
            contentDocumentIds.add(cdl.ContentDocumentId);
        }
        
        // Find all content versions based on the content document IDs
        List<ContentVersion> contentVersions = [
            SELECT ContentDocumentId, VersionData, CreatedDate
            FROM ContentVersion
            WHERE ContentDocumentId IN :contentDocumentIds
            ORDER BY CreatedDate DESC
        ];
        
        // Map content document ID to its content versions
        Map<Id, List<ContentVersion>> documentVersionsMap = new Map<Id, List<ContentVersion>>();
        for (ContentVersion version : contentVersions) {
            if (!documentVersionsMap.containsKey(version.ContentDocumentId)) {
                documentVersionsMap.put(version.ContentDocumentId, new List<ContentVersion>());
            }
            documentVersionsMap.get(version.ContentDocumentId).add(version);
        }
        
        // Prepare the list of files with their IDs and base64 data
        List<Map<String, String>> pdfFilesWithIds = new List<Map<String, String>>();
        for (String status : statusOrder) {
            for (Quote quote : quotes) {
                if (quote.Status == status) {
                    List<ContentVersion> allVersionsForQuote = new List<ContentVersion>();
                    for (ContentDocumentLink link : contentDocumentLinks) {
                        if (link.LinkedEntityId == quote.Id && documentVersionsMap.containsKey(link.ContentDocumentId)) {
                            allVersionsForQuote.addAll(documentVersionsMap.get(link.ContentDocumentId));
                        }
                    }
                    allVersionsForQuote.sort();
                    
                    for (ContentVersion version : allVersionsForQuote) {
                        Map<String, String> pdfData = new Map<String, String>();
                        pdfData.put('ContentDocumentId', version.ContentDocumentId);
                        pdfData.put('Base64Data', EncodingUtil.base64Encode(version.VersionData));
                        pdfFilesWithIds.add(pdfData);
                    }
                }
            }
        }
        
        return pdfFilesWithIds;
    }
    
    @AuraEnabled
    public static void saveMergedPdf(Id opportunityId, String base64Pdf, String fileName) {
        // Decode the Base64 string into a Blob
        Blob pdfBlob = EncodingUtil.base64Decode(base64Pdf);
        
        // Create a ContentVersion record
        ContentVersion contentVersion = new ContentVersion();
        contentVersion.Title = fileName;
        contentVersion.PathOnClient = fileName;
        contentVersion.VersionData = pdfBlob;
        insert contentVersion;
        
        // Query the ContentDocumentId
        ContentDocument contentDocument = [
            SELECT Id FROM ContentDocument WHERE Id IN (
                SELECT ContentDocumentId FROM ContentVersion WHERE Id = :contentVersion.Id
            )
            LIMIT 1
        ];
        
        // Link the ContentDocument to the Opportunity
        ContentDocumentLink contentDocumentLink = new ContentDocumentLink();
        contentDocumentLink.ContentDocumentId = contentDocument.Id;
        contentDocumentLink.LinkedEntityId = opportunityId;
        contentDocumentLink.ShareType = 'V'; // Viewer access
        insert contentDocumentLink;
    }
    
    @AuraEnabled
    public static void sendEmailWithPdf(Id opportunityId, String base64Pdf, String fileName, String emailAddress) {
        // Decode the Base64 string into a Blob
        Blob pdfBlob = EncodingUtil.base64Decode(base64Pdf);
        
        // Create the email attachment
        Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
        attachment.setFileName(fileName);
        attachment.setBody(pdfBlob);
        attachment.setContentType('application/pdf');
        
        // Prepare the email
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(new String[] { 'deepakjaiswal@astreait.com' , 'vishal@astreait.com'});
        email.setSubject('Merged PDF Document');
        email.setPlainTextBody('Please find the merged PDF document attached.');
        email.setFileAttachments(new Messaging.EmailFileAttachment[] { attachment });
        
        // Send the email
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
    }
    
}