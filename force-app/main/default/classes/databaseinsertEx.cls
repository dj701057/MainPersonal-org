public class databaseinsertEx {
    public static void test(){
        List<Account> accountsToInsert = new List<Account>();
        Account accountToUpdate;
        for(Integer i=0; i<3; i++){
            Account acc = new Account(Name = 'Deepak', BillingCity = 'Noida');
            accountsToInsert.add(acc);
}

Database.insert(accountsToInsert);
}

}