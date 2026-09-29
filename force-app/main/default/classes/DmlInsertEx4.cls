public class DmlInsertEx4 {
    public static void test(){
        List<Account>accList=new List<Account>();
        
        for(integer i=1;i<=10;i++){
            
             Account a=new Account(Name='Dml Insert test'+i);
             accList.add(a);
            
        }
        insert accList;
            
    }
    

}