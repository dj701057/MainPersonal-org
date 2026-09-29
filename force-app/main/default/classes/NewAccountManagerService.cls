@RestResource(URLmapping='/NewAccountService/*')
Global class NewAccountManagerService {
    @HttpPost
    Global static String InsertNewAccount(string accName,string accRating ,string accIndustry,
                                         Decimal accRevenue,string accPhone,string accFax,
                                         string accType,string accActive)
    {
        Account acc =new Account();
        	acc.Name = accName;
        	acc.Rating = accRating;
        	acc.Industry = accIndustry;
        	acc.Phone = accPhone;
        	acc.AnnualRevenue = accRevenue;
        	acc.Type = accType;
        	acc.Active__c = accActive;
        	acc.Fax = accFax;
        
        insert acc;
		//return 'Account is Created';   
        if(acc.Id!=null)
        {
            return 'Account Created';
        }
        else
        {
            Return 'Something Went Wrong';
        }
    }
}