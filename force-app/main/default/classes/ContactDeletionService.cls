@RestResource(URLMapping='/ContactDelService/*')
Global class ContactDeletionService {
	@HttpDelete
    Global static string RemoveRelatedContacts()
    {
        Map<String,string> inputParams = RestContext.Request.Params;
        
        List<Contact>lstContacts =[select id ,firstname,lastname,Account.Name 
                                   from Contact Where account.name =:inputParams.get('Name')];
        Delete lstContacts;
        return 'Contacts Deleted';
    }
}