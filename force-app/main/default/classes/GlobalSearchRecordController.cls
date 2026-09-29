public class GlobalSearchRecordController {
    public string searchText{get;set;}
    public List<Account> lstAccounts{get;set;}
    public List<Contact> lstContacts{get;set;}
    public List<Lead> lstLeads{get;set;}
    
    public void SearchRecords()
    {
        lstAccounts = new List<Account>();
        lstContacts= new List<Contact>();
        lstLeads= new List<Lead>();
        
        if(searchText != null && searchText !='')
        {
            string searchQuery = 'FIND '+'\''+ searchText + '*'+'\''+' IN ALL FIELDS RETURNING  '+
                                   'Account(ID,name,Rating,industry,phone,fax,type),'+
                                   'Contact(ID,firstname,lastname,phone,fax),' +
                                   'Lead(ID,firstname,lastname,rating,industry)';
                                   
           List<List<SObject>> lstRecords = Search.Query(searchQuery);
           lstAccounts = (List<Account>) lstRecords.Get(0); 
           lstContacts = (List<Contact>) lstRecords.get(1); 
           lstLeads = (List<Lead>) lstRecords.Get(2); 
       }
    }
}