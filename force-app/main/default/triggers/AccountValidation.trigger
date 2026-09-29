trigger AccountValidation on Account (before insert) {
     set<id> accid = new set<id>();
     for(Account ac: Trigger.new){
        if (ac.id != null) 
            accid.add(ac.id);
    }
    //Map<id, > fetch = new Map<id,Address__c>([select id,name,City__c,Country__c from Address__c where id in : accid]);

    //for(Account a : Trigger.new){
         //Address__c ad = fetch.get(a.id);

       // if(A.id !=null)

        //a.BillingCountry = ad.Country__c;
       // a.Billingcity = ad.City__c;
        
    }

//}