public with sharing class AccountHelper {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountList() {
        return [select Id,Name,Type,Rating,Phone ,Website,AnnualRevenue from Account];

    }
}