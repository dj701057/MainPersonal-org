public class Assignment_2_3_a {
    public static void sol(){
        List<Account> acclist = [Select Name, (Select Name from Opportunities), (Select Name from Contacts),
                                 (Select ID from Notes) from Account where Name LIKE 'B%'];
      for(Account a : acclist){
        System.debug('Account Name: '+ a.Name);
          List<Opportunity> opplist = a.Opportunities;
                    for(Opportunity o : opplist){
                       System.debug('Opportunity Name :'+ o.Name);
                     }
          List<Contact> conlist = a.Contacts;
                    for(Contact c : conlist){
                       System.debug('Contact Name: '+c.Name);
                    } 
          List<Note> notelist = a.Notes;
                    for(Note n : notelist){
                       System.debug('Note: '+n.ID);
                    } 

    }

}
}