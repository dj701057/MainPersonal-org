public class ContactAndLeadSearch {
    public static List<list<sObject>> searchContactsAndLeads(string lastName){
        List<list<sObject>>searchList=[FIND :lastName IN NAME FIELDS 
                   RETURNING Contact(Name),Lead(FirstName)];
        return searchList;
        
    }

}