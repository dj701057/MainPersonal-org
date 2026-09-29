public class ShowRealtedRecordController {

    public List<Selectoption> lstOptions{get;set;}
    public string selectedAccountId{get;set;}
    public List<Contact> lstContact{get;set;}
    public List<Opportunity> lstOpp{get;set;}
    public List<Case> lstCases{get;set;}
    
    public ShowRealtedRecordController ()
    {
       lstOptions = new List<Selectoption> ();
       lstOptions.Add(new SelectOption('' ,'---None---'));
       for(Account acc : [select id,name from Account order by name])
       {
         lstOptions.Add(new SelectOption(acc.id , acc.name));
       }
    }
    public void GetRelatedRecords()
    {
        lstContact = new List<Contact>();
        lstOpp =new List<Opportunity>();
        lstCases = new List<Case>();
        if(selectedAccountId !=null && selectedAccountId !='')
        {
          List<Account>lstAccounts =  [select id,name,
                                        (select id ,firstName,lastName,email,phone,fax,mailingCity,mailingState ,title from contacts),
                                        (select id ,name ,stageName,amount from opportunities),
                                        (select id,subject,type,origin,status,priority from Cases)
                                            from Account Where id =:selectedAccountId];
          for(Account acc : lstAccounts )
          {
              //lstContact = (List<Contact>)lstAccounts.Get(0);
              //lstOpp = (List<Opportunity>)lstAccounts.Get(1);
              //lstCases =(List<Case>) lstAccounts.Get(2);
              
              lstContact =acc.Contacts;
              lstOpp = acc.Opportunities;
              lstCases = acc.Cases;
           }
        }
    }
}