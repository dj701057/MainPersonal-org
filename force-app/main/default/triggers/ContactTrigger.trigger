trigger ContactTrigger on Contact (after insert, after Update, after Delete) {
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            ContactTriggerHelper.afterInsert(trigger.newMap);
        }
    }

}