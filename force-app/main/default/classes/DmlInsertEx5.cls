public class DmlInsertEx5 {
    public static void test(){
        Account  a = [select name from account where name like 'A%'];

        Contact c = new Contact(lastname='test', Accountid=a.id);
        insert c;
         }

}