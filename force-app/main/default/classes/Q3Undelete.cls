public class Q3Undelete {
    public static void test(){
          list<Account>accList =[select Name from Account where Name like '%Updated'And isDeleted=true ALL ROWS ];
        undelete acclist;
    }

}