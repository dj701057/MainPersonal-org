public class DmlUpdateEx5 {
    public static void test(){
        Account a = [select name from Account where name like 's%' limit 1];
        a.name = 'Salesforce DML test';
        Update a;

        
    }


}