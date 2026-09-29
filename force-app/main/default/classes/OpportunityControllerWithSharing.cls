public with sharing class OpportunityControllerWithSharing {
     public static List<opportunity> getOpportunities(){
      /*  return [select id,Name from Opportunity]; */
      return OpportunityController.getRecords(); 
    }

}