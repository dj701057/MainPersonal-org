trigger Lead_owner on Lead (After insert) {
   /* Set <Id> accIds=new Set<Id>();
    for(Lead lead : trigger.New)
        AccIds.add(Lead_owner__c);
    Map<Id,Account> mapAccount=new Map<Id,Account>([Select Id,OwnerId from Account where id IN:accIds]);
    for(Lead lead:Trigger.New)
        lead.OwnerId=mapAccount.get(lead.Lead_ow).OwnerId; */

}