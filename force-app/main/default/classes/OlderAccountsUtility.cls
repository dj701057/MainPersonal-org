public class OlderAccountsUtility {
    public static void updateOlderAccounts(){
        Account [] oldAccounts=[select id,Description from account ORDER By CreatedDate ASC limit 5 ];
        for(Account acc:oldAccounts){
            acc.Description='Heritage Account';
        }
        update oldAccounts;
    }

}