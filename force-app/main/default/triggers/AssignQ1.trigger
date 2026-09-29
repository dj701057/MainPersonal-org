//When an account is inserted or updated,check whether any opportunity is linked to it or not,if
//not then create one whose name is First Opportunity-<Account Name>
trigger AssignQ1 on Account (after insert ,after update) {
    List<Opportunity> opp = new List<Opportunity>();
    
    Map<ID, Account> accountmap = new Map<ID, Account>([Select Id, Name, (Select Id From Opportunities) From Account Where Id In :Trigger.New]);
    for(Account a : trigger.new)
    {
        if(accountmap.get(a.Id).Opportunities.size() == 0)
        {
            opp.add(new Opportunity(AccountId = a.Id, Name ='First Opportunity '+a.Name, StageName ='prospecting',CloseDate =System.today()));
        }

    }
    if(opp.size()>0)
    {
        Insert opp;
    }
}