@RestResource(urlMapping='/getAllAccounts')
global class SM_CustApp_Pagination {
    
    @HttpGet
    global static AccountResponse getAllAccounts() {
        try {
            // Query all existing account records
            List<Account> allAccounts = [SELECT Id, Name FROM Account];

            // Prepare the response object
            AccountResponse accRes = new AccountResponse();
            accRes.Status = 'Success';
            accRes.Message = 'Accounts retrieved successfully';
            
            // Store the account IDs in the response
            accRes.AccountIds = new List<String>();
            for (Account acc : allAccounts) {
                accRes.AccountIds.add(acc.Id);
            }
            return accRes;
        } 
        catch (Exception e) {
            AccountResponse accResError = new AccountResponse();
            accResError.Status = 'Error';
            accResError.Message = e.getMessage();
            return accResError;
        }
    }
    
    global class AccountResponse {
        public String Status;
        public String Message;
        public List<String> AccountIds;
    }
}