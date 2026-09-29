@isTest
private class AccountControllerTest {

    @isTest
    static void testGetCustomField() {
        // Create a test Account record
        Account testAccount = new Account(Name='Test Account');
        testAccount.Custom_Field__c = 'Test Value';
        insert testAccount;

        // Call the getCustomField method with the test Account record's Id
        String customFieldValue = AccountCustomController.getCustomField(testAccount.Id);

        // Verify that the custom field value is returned correctly
        System.assertEquals('Test Value', customFieldValue);
    }
}