trigger QuoteTrigger on Quote (before insert, before update, after insert, after update) {
    if (Trigger.isInsert && Trigger.isBefore) {
        QuoteTriggerHandler.addQuoteVersion(Trigger.new);
    }

    if (Trigger.isInsert && Trigger.isAfter) {
        QuoteTriggerHandler.updateExistingQuotes();
    }
}