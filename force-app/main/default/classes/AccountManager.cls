public with sharing class AccountManager {
    @AuraEnabled
    public static List <Account> GetAccount(){
        
            return [select id,name,Phone,website from Account LIMIT 10];
        }
   
}