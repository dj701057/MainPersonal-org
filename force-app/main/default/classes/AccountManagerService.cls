@RestResource(URLMapping='/AccountsService')
//declare Global not public
Global class AccountManagerService {
    @HttpGet
    Global static List<Account> GetAllAccountRecords(){
       List<Account>lstAccounts= [select id,name,rating,industry,annualrevenue,
        						 phone from Account Order by name];
        
        return lstAccounts;
    }
}