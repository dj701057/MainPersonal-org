@RestResource(URLMapping='/AccDelService/*')
Global class AccountDeleteManagetService {
	@HttpDelete
    Global static string DeleteAccRecord()
    {
       Map<String,string> inputParams = RestContext.Request.Params;
        
        string AccRecordId = inputParams.get('Id');
        Delete [select id ,name from Account Where id=:AccRecordId];
        
        return 'Record Deleted';
    }
}