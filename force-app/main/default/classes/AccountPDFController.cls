public class AccountPDFController {
    public List<Account> getAccountList() {
        return [SELECT Name, Phone, Industry FROM Account LIMIT 10]; // Adjust the query as needed
    }
    public List<Contact> getContactList() {
        // Query and return a list of Contact records
        return [SELECT FirstName, LastName, Phone FROM Contact LIMIT 10];
    }
}