@RestResource(urlMapping='/accountUpdateOrInsert/*')
global with sharing class SM_CustApp_CreateOrUpdateAccount {
    @HttpPost
    global static String updateOrInsertAccount(String phoneNumber, String accountName) {
        List<Account> existingAccounts = [SELECT Id, Name, Phone FROM Account];
        
        Account matchingAccount =  null;
        for (Account acc : existingAccounts) {
            if (acc.Phone == phoneNumber) {
                matchingAccount = acc;
                break;
            }
        }

        if (matchingAccount != null) {
            matchingAccount.Name = accountName;
            update matchingAccount;
            return 'Account updated successfully';
        } else {
            Account newAccount = new Account(Name = accountName, Phone = phoneNumber);
            insert newAccount;
            return 'New account created successfully';
        }
    }
}