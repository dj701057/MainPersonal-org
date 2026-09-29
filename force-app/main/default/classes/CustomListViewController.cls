public class CustomListViewController {
    public List<Opportunity> Opportunities {get; set;}
    
    public CustomListViewController() {
        Opportunities = [SELECT Id, Name, StageName, CloseDate FROM Opportunity];
    }
    
    public void updateOpportunities() {
        List<Opportunity> selectedOpps = new List<Opportunity>();
        for(Opportunity opp : Opportunities) {
            if(opp.selected__c) {
                opp.StageName = 'Closed Won';
                selectedOpps.add(opp);
            }
        }
        update selectedOpps;
    }
}