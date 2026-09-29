public class AssignQ3Update {
    public static void test(){
        list<Account>accList =[select Name from Account where CreatedDate=Today];
        for(Account a:accList){
            a.Name=a.name+'Updated';
}
        update accList;
}

}