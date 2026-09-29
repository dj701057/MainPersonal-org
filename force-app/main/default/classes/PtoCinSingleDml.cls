public class PtoCinSingleDml {
    public static void test(){
        List<sObject> records = new List<sObject>();
        records.add(new Account(AccountExternalId__c='1234555', Name='ABCD Company'));

        records.add(new Contact(account=new Account(AccountExternalId__c='1234555'),lastname = 'Testlast', ContactExternalId__c='3525'));

       // records.add(new AccountContact__c (Contact__r = new Contact(ContactExternalId__c='3525')));

        insert records;

    }

}