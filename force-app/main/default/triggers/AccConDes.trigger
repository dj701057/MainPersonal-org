//if account industry isupdated put same in contact description
trigger AccConDes on Account (After update) {
    map<String,Account> mapAc=new map<string,Account>();
    list<Contact> lstCon=new list<Contact>();
    list<Contact> lstConUpdate=new list<Contact>();
    if(trigger.isExecuting && trigger.isAfter && trigger.isupdate){
        for(Account ac:trigger.new){
            if(ac.Industry!=trigger.oldmap.get(ac.Id).Industry){
               mapAc.put(ac.Id,ac); 
                
            }
            if(mapAc.size()>0){
                lstCon=[select Id,Description, Account.Id from Contact where Account.Id=:mapAc.keySet()] ;
                
                
            }
            if(lstCon.size()>0){
                for(Contact ct:lstCon){
                    ct.description=mapAc.get(ct.AccountId).Industry;
                    lstConUpdate.add(ct);
                }
            }
        } 
    }
    update lstConUpdate;
   

}