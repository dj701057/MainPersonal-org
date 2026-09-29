public with sharing class ContactsVisualforceController {
    public List<Contact> contacts {get;set;}
    public ContactsVisualforceController(){
        contacts = [select id,name,account.name from Contact order by account.name];
    }
    
}