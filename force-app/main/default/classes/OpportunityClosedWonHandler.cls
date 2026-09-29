public class OpportunityClosedWonHandler {
    public static void handleClosedWon(Map<Id, Opportunity> newOpportunities) {
        List<Messaging.SingleEmailMessage> emailMessages = new List<Messaging.SingleEmailMessage>();
        
        for (Opportunity opp : newOpportunities.values()) {
            // Check if the Opportunity stage is Closed Won
            if (opp.StageName == 'Closed Won') {
                // Get related Contact
                Account relatedContact = [SELECT Id, Email__c FROM Account WHERE Id = :opp.Accountid LIMIT 1];
                
                if (relatedContact != null && relatedContact.Email__c != null) {
                    // Create Email Message
                    Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                    email.setToAddresses(new List<String>{relatedContact.Email__c});
                    email.setSubject('Opportunity Closed Won Notification');
                    email.setPlainTextBody('Dear Contact,\n\nThe Opportunity ' + opp.Name + ' has been closed successfully.');
                    
                    // Attach Opportunity records
                    Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
                    attachment.setFileName('Opportunity_' + opp.Name + '.csv');
                    attachment.setBody(Blob.valueOf(getOpportunityDetailsCSV(opp)));
                    email.setFileAttachments(new List<Messaging.EmailFileAttachment>{attachment});
                    
                    emailMessages.add(email);
                }
            }
        }
        
        // Send Email Messages
        if (!emailMessages.isEmpty()) {
            Messaging.sendEmail(emailMessages);
        }
    }
    
    private static String getOpportunityDetailsCSV(Opportunity opp) {
        // Customize this method to generate CSV content based on Opportunity details
        // For example, you can include Opportunity fields like Name, Amount, CloseDate, etc.
        String csvContent = 'Opportunity Name,Amount,Close Date\n';
        csvContent += opp.Name + ',' + String.valueOf(opp.Amount) + ',' + String.valueOf(opp.CloseDate);
        return csvContent;
    }
}