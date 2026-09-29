public class ContactCreated {
    public static void onlyTwoContactCreated(List<Contact> conList){
        Set<Id> acntId = new Set<Id>();
        
        for(Contact c:conList) {
            if(c.AccountId != null)
                acntId.add(c.AccountId);
        }
        List<account> acntList =[select id,(select id,name from contacts) from account where id in:acntid];
        map<id,integer> MapOfAccidvsSize =new map<id,integer>();
        for(account a: acntList) {
            if(a.contacts.size()>=3)
                MapOfAccidvsSize.put(a.id,a.contacts.size());
        }
        for(contact c:conList) {
            if(MapOfAccidvsSize.containskey(c.accountid))
                c.adderror('cant add more than 3 contacts');
        }
        
    }
    
}