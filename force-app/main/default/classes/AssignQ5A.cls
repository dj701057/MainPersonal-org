public class AssignQ5A {
    public static void test(){
        list<Account>accList =[select Name,id from Account where Name like '_R%' ];
        delete accList;
    }

}