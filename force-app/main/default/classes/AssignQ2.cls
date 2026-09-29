public class AssignQ2 {
    public static void AssignQ2(){
        set<id>opp=new Set<id>();
        list<Account>acclist=[select id ,name , (select name from opportunities) from account];
        for(Account acc: acclist)
        {
            if(acc.opportunities.size()==0)
            {
                
                opp.add(acc.Id);
            }
            
        }
    }

}