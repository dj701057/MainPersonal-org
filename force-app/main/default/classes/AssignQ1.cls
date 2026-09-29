public class AssignQ1 {
    public static void test(){
        List<Account> accs = [SELECT Id, Name FROM Account WHERE Name like 's%'];
        for(Account a : accs){ 
            a.Name = a.NAME +'test' ;
            
        }

    }

}