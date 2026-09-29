public class ContactTriggerHelper {
    
    public static void afterInsert(Map<Id, Contact> mapOfCOntacts){
        
        Set<Id> AccIds = new Set<Id>();
        for(Contact con: mapOfCOntacts.values()){
            if(con.AccountId != null){
                AccIds.add(con.AccountId);
            }
            
        }
        
        list<Account> accountsToUpdate = new List<Account>();
        Map<Id, Integer> mapOfCount = new Map<Id, Integer>();
        AggregateResult[] result = [SELECT COUNT(Id) countCon, AccountId accId  FROM Contact where AccountId IN: AccIds
                                   GROUP BY AccountId];
        for(AggregateResult res : result){
           Id accId = (Id)res.get('accId');
            Integer count = (Integer)res.get('countCon');
            mapOfCount.put(accId, count);     
        }
        
        for(Id accountId : AccIds)   {
            Account acc = new Account();
            acc.Id = accountId;
            if(mapOfCount.containsKey(accountId)){
                acc.Contacts_Count__c = mapOfCount.get(accountId);
            }
            else{
               acc.Contacts_Count__c = 0; 
            }
           accountsToUpdate.add(acc);
        }
        if(!accountsToUpdate.isEmpty()){
            Update accountsToUpdate;
        }
    }

}