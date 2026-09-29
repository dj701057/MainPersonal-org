//Fetch all the opportunity records whose close date lies btw 2 dates passed as an arguments to th function(firstdate,second date)
//and opportunity owner'name is Saurman D\'Sauza
public class Assignment_2_2 {
     public static void sol(Date firstDate, Date SecondDate){
        List<sObject> l = [Select Name from Opportunity 
        where CloseDate > :firstDate   AND CloseDate <    :SecondDate AND Owner.Name = 'Saurman D\'Sauza'];
        System.debug(l);
    }


}