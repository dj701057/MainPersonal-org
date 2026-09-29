public class AccountTotalAmountHandler {
    public static Boolean isFirstTime = true;

    public static void accountAmount(Map<Id, Account> mapOfUpdatedAccounts) {
        // verify if map is not empty and if is first time
        if (!mapOfUpdatedAccounts.isEmpty() && isFirstTime == true) {
            isFirstTime = false;
            // Aggregate the opportunities belongs to the updated accounts.
            for (AggregateResult agrObj : [SELECT AccountId, Sum(Amount) sumAmount FROM Opportunity WHERE AccountId IN :mapOfUpdatedAccounts.keySet() GROUP BY AccountId]) {
                // Get the current account id to use as key in the received map
                Id accountId = (Id) agrObj.get('AccountId');
                // perform the field update in the received map
                mapOfUpdatedAccounts.get(accountId).Total_Opportunity_Amount__c = (Decimal) agrObj.get('sumAmount');
            }
        }
    }

}