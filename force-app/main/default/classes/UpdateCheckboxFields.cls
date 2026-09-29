@RestResource(urlMapping='/updateCheckboxFields/*')
global class UpdateCheckboxFields {
    @HttpGet
    global static void updateFields() {
        // Update checkbox fields for relevant accounts
        List<Account> accountsToUpdate = [SELECT Id, Closed_Chrome__c FROM Account WHERE LastModifiedDate = TODAY];
        for(Account acc : accountsToUpdate) {
            acc.Closed_Chrome__c = false; // Update checkbox field
        }
        update accountsToUpdate;
    }
}