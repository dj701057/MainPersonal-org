trigger AcctWithCont on Account (before insert) {
    List<Contact>cntList=new List<Contact>();
    for(Account a:trigger.New){
        system.debug('trigger.new List:- '+trigger.New);
        Contact c=new Contact();
        c.accountid=a.id;
        c.LastName=a.Name;
        c.Phone=a.Phone;
        cntList.add(c);
    }
   insert cntList;

}