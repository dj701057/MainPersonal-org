//Get sum of amount of all closed opportunities owned by the current logged in user.
//the sum should be displayed for every fiscal yearby a single quarry
public class Assignment_2_1 {
    public static void sol(){
        
      List<AggregateResult> l = [Select Sum(Amount) from Opportunity where CloseDate < TODAY AND OwnerId =:UserInfo.getUserId() 
                                 GROUP BY FISCAL_YEAR(CloseDate)];
        
        System.debug(l);
    }
}






//Fiscal Year starts from April and ends at March