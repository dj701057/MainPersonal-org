trigger cloneOpportunity on Opportunity (after insert,after update) {
    if(trigger.isAfter &&trigger.isupdate){
        List<opportunity> oppList =new List<opportunity>();
        for(opportunity opp :trigger.new){
            opportunity oldOpp=trigger.oldMap.get(opp.Id);
            if(opp.Clone__c ==true && oldOpp.Clone__c ==false){
               
                
            }
        }
    }

}