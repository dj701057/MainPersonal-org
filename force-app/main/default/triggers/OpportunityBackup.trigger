trigger OpportunityBackup on Opportunity (after update) 
{

      List<opportunity> lstToInsrt = new List<opportunity>();      
    for(Opportunity op1 : Trigger.new)
    {
         if(trigger.oldMap.get(op1.Id).Name !=op1.Name)
         {
             opportunity backup = new opportunity();
             backup.Name = trigger.oldMap.get(op1.AccountId).Name;
             lstToInsrt.add(backup);
         }
    }
    if(lstToInsrt.size()>0)
    {
        update lstToInsrt;
    }
    
}