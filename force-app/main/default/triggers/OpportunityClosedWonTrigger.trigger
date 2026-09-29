trigger OpportunityClosedWonTrigger on Opportunity (after insert, after update) {
    if (Trigger.isAfter) {
        if (Trigger.isInsert || Trigger.isUpdate) {
            OpportunityClosedWonHandler.handleClosedWon(Trigger.newMap);
        }
    }
}