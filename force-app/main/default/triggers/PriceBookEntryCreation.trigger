trigger PriceBookEntryCreation on Product2 (before insert,after insert,before update ,after update) {
    if((trigger.isInsert || trigger.isUpdate) && trigger.isAfter){
        
        PriceBookEntryCreationHandler.createPriceBookEntry(trigger.new);
    }
}