trigger StudentTrigger on Student__c (before insert, before update) {
    if (Trigger.isBefore) {
        if (Trigger.isInsert || Trigger.isUpdate) {
            StudentTriggerHandler.preventDuplicateEmailByMap(Trigger.new);
            StudentTriggerHandler.updateDescriptionBasedOnGender(Trigger.new);
        }
    }
}