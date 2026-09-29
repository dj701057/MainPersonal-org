public class Assignment_2_4 {
    public static void sol(){
   List<List<sObject>> l = [FIND 'Test' IN Name Fields RETURNING Opportunity(Name, CloseDate where CloseDate = THIS_FISCAL_YEAR),
                            Account(Name where OwnerId = :UserInfo.getUserId())];
   List<Opportunity> opplist = (List<Opportunity>)l[0];
        List<Account> acclist = (List<Account>)l[1];
        for(Account a : acclist){
            System.debug('Account Name: '+ a.Name);
        }
        for(Opportunity o : opplist){
            System.debug('Opportunity Name:' + o.Name);
            System.debug('Opportunity CloseDate:' + o.CloseDate);

        }
    }


}