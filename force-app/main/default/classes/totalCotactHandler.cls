public class totalCotactHandler {
    public static void countContacts(List<contact> oldList,List<contact> newList){
        set<id> accountIds=new set<id>();
        for(contact c:newList){
            if(c.accountId!=null){ 
                accountIds.add(c.accountId);
            
            }
        }
        for(contact c:oldList){
            if(c.accountId!=null){
                accountIds.add(c.accountId);
            }
        }
        List<Account> accounts=[select Id,countContact__C,(select id from contacts)from account where Id in:accountIds];
        if(!accounts.isEmpty()){
            for(Account acc:accounts)
            {
                acc.countContact__c=acc.contacts.size();
            }
        }
        update accounts;
    }

}