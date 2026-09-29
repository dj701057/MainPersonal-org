public without sharing class OpportunityControllerWithOutSharing {
    public static List<opportunity> getOpportunities(){
        return [select id,Name from Opportunity];
    }

}
//without sharing is used for calling a class from another class which is declared with with sharing