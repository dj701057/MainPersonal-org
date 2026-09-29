public class Assignment_2_5 {
    public static void sol(){
        List<Account> acclist = [Select Name, (Select Name from Opportunities), (Select Name from Contacts), 
                                 (Select ID from Notes) from Account where Name LIKE 'B%'];
        Map<ID, List<Opportunity>> oppMap = new Map<ID, List<Opportunity>>();
        Map<ID, List<Contact>> conMap = new Map<ID, List<Contact>>();
        Map<ID, List<Note>> noteMap = new Map<ID, List<Note>>();
        
    for(Account a : acclist){
           List<Opportunity> opplist = a.Opportunities;
            oppMap.put(a.ID, opplist);
           List<Contact> conlist = a.Contacts;
            conMap.put(a.ID, conlist);
           List<Note> notelist = a.Notes;
            noteMap.put(a.ID, notelist);
       }  
        System.debug(oppMap);
        System.debug(conMap);
        System.debug(noteMap);
        
    }


}