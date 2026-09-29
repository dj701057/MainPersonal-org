public class Assign4_1 {
    public static void sol1(){
       List<Opportunity> opp = new List<Opportunity>();
    
    Map<ID, Account> accountmap = new Map<ID, Account>([Select Id, Name, (Select Id From Opportunities) From Account 
                                                        Where Id In :Trigger.New]);
    for(Opportunity o:opp)
    {
        if(accountmap.get(o.Id).Opportunities.size() == 0)
        {
            opp.add(new Opportunity(AccountId = o.Id, Name ='First Opportunity '+o.Name, StageName ='prospecting',
                                    CloseDate =System.today()));
        }

    }
    if(opp.size()>0)
    {
        Insert opp;
    }
    }

}