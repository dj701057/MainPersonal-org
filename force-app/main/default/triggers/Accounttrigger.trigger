trigger Accounttrigger on Account (before insert,before update, after update) {
    if(trigger.isBefore && trigger.isInsert){
        system.debug('i am in AccountEmailer before inseart context');
    }
    if( trigger.isUpdate){
        if(trigger.isBefore){
            for(Account acc:trigger.new){
                system.debug('New Name:-'+ acc.Name);
                system.debug('Old Name:-'+ Trigger.oldMap.get(acc.Id).Name);
            }
            
        
    }
}
}