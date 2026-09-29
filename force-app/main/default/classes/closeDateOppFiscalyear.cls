public class closeDateOppFiscalyear {
    public static void main(){
        list<opportunity> opplist =[SELECT Id,closedate FROM Opportunity WHERE OwnerId = : UserInfo.getUserId() AND CloseDate = THIS_FISCAL_YEAR limit 10];
        system.debug('opplist-->'+opplist);

list<opportunity> opplist2 =[SELECT Id,closedate FROM Opportunity WHERE CloseDate = LAST_FISCAL_YEAR limit 10];
system.debug('opplist2-->'+opplist2); 
    }

}