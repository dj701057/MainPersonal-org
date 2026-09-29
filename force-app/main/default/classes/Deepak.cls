public class Deepak {
    public static void test(){
list<Account> acclist=new list<Account>();
list<contact> conlist=new list<contact>();
list<opportunity> opplist= new list<opportunity>();   
set<id> acctId =new set<id>();
acclist=[select id ,name from account where name LIKE :'s%' ];
        for (Account a :acclist){
            acctId.add(a.Id);
        }
        conlist=[select id ,LastName from contact where AccountId =:acctId];
        opplist=[select id ,Name from opportunity where AccountId =:acctId];
        
        system.debug(acclist);
        system.debug(conlist);
        system.debug(opplist);
    }
}