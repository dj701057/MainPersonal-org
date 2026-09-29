public class Assignment_2_3_b {
    public static void sol(){
         List<Opportunity> opplist = [Select Name, AccountId, Account.Name from Opportunity
                                      where AccountId IN (Select AccountId from Contact) AND Name LIKE '%A'];

     for(Opportunity o : opplist){
        System.debug('Opportunity Name: ' +o.Name);
        System.debug('Account Id: '+ o.AccountId);
        System.debug('Account Name: '+ o.Account.Name);
            
      }
     
  }


}