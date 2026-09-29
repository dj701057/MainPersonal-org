@RestResource(URLmapping='/BulkNewAccountService/*')
Global class BulkNewAccountManagerService {
    @HttpPost
    Global static String InsertNewBulkAccount()
    {
        string accRecordCollection = RestContext.request.requestBody.ToString();
		List<Account> lstAccounts =(List<Account>) System.JSON.deserialize(accRecordCollection ,List<Account>.Class);
		  
        if(lstAccounts.isEmpty())
        {
			insert lstAccounts;
            return 'Success';
        }
        else
        {
            Return 'Failed';
        }
    }
}