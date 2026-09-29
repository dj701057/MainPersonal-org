public class OpportunityController {
    public static List<opportunity> getRecords(){
        return [select id,Name from Opportunity];

    }

}