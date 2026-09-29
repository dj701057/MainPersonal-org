public with sharing class GetAccountList {
    @AuraEnabled(cacheable=true)
    public static List<Account> GetAccountLists() {
        return [select Id,Name,Type,Rating,Phone ,Website,AnnualRevenue from Account];

    }
}