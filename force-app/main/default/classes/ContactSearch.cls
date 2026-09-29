public class ContactSearch {
    public static list<contact>searchForContacts(string a,string b){
        list<contact>con=[select id,name from contact where lastName=:a and MailingPostalCode=:b];
        return con;
    }

}