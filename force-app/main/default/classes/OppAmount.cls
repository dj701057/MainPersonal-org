public class OppAmount {
    public static void OppAmount(){
      List<AggregateResult> aggr = [select CALENDAR_YEAR(CloseDate) Year,SUM(Amount)  Amount  from Opportunity
           where CloseDate = THIS_FISCAL_YEAR group by CALENDAR_YEAR(CloseDate) ];
       // Select Id, Name From User Where Id =:UserInfo.getUserId();
       List<Account> accName =  [Select Id,Name from Account where OwnerId = : UserInfo.getUserId()];
     

       map<Integer,Decimal> Sumofamount = new map <Integer,Decimal>();
         System.debug(aggr);
        system.debug(accName);
        }

}