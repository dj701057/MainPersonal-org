trigger Assigment4_3 on Account (After delete) {
    List<Account> l = new List<Account>();
    for(Account acct : trigger.old) {
        if(String.isNotBlank(acct.MasterRecordId)) { 
           l.add(new Account(Name = acct.Name, Phone = acct.Phone));  
        }         
    }
    if(l.size() > 0) {
        insert l;
    }    

}