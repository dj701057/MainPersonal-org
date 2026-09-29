public class QuoteTriggerHandler {
    public static Map<Id, Decimal> opportunityVersionMap = new Map<Id, Decimal>();
    public static List<Quote> existingQuoteToUpdate = new List<Quote>();

    public static void addQuoteVersion(List<Quote> newQuoteList) {
        Set<Id> opportunityIds = new Set<Id>();

        for (Quote newQuote : newQuoteList) {
            opportunityIds.add(newQuote.OpportunityId);
        }

        for (Quote existingQuote : [SELECT OpportunityId, Version__c, Status FROM Quote WHERE OpportunityId IN :opportunityIds]) {
            opportunityVersionMap.put(existingQuote.OpportunityId, existingQuote.Version__c);
            existingQuote.Status = 'Rejected';
            existingQuoteToUpdate.add(existingQuote);
        }

        for (Quote newQuote : newQuoteList) {
            if (opportunityVersionMap.containsKey(newQuote.OpportunityId)) {
                Decimal existingVersion = opportunityVersionMap.get(newQuote.OpportunityId);
                newQuote.Version__c = existingVersion + 1;
            } else {
                newQuote.Version__c = 1;
            }
        }
    }

    public static void updateExistingQuotes() {
        if (!existingQuoteToUpdate.isEmpty()) {
            system.debug('existingQuoteToUpdate'+existingQuoteToUpdate);
            update existingQuoteToUpdate;
        }
    }
}