trigger CountGender2 on Contact (after insert,after update,after delete) {
    
    List<Contact> con = Trigger.isdelete ? trigger.old : trigger.new;
    List<Contact> con1 = Trigger.isUpdate ? trigger.old : trigger.new;
    Set<Id> accountIds = new Set<Id>();
    
    for (Contact c : con) {
        if (c.accountid != null) {
            accountIds.add(c.accountid);
        } 
    }
    
    List<account> femaleGenderList = [SELECT Count_Of_Female_Gender__c,(SELECT Id FROM Contacts WHERE Gender__c='Female') FROM Account WHERE Id IN :accountIds];    
    for(account a :femaleGenderList)  {
        a.Count_Of_Female_Gender__c = a.contacts.size();
    }
    
    List<account> maleGenderList = [SELECT Count_Of_Male_Gender__c,(SELECT Id FROM Contacts WHERE Gender__c='Male') FROM Account WHERE Id IN :accountIds];    
    for(account a :maleGenderList)  {
        a.Count_Of_Male_Gender__c = a.contacts.size();
    }
    
    if(femaleGenderList.size()>0){
        UPDATE femaleGenderList ;
    }
    if(maleGenderList.size()>0){
        UPDATE maleGenderList ;
    }
}