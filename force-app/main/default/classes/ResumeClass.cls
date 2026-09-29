public with sharing class ResumeClass {
 
    /*Using multiple parameter in apex  controller */
    @AuraEnabled
    public static scoreCard__c submitScoreAction(string cardName, string cardEmail, string cardPhone, string cardCity, integer cardAnnual, string cardDesignations){
        scoreCard__c scoreCardObj = new scoreCard__c();
        scoreCardObj.Name=cardName;
        scoreCardObj.Email__c=cardEmail;
        scoreCardObj.Phone_No__c=cardPhone;
        scoreCardObj.City__c=cardCity;
        scoreCardObj.Annual__c=cardAnnual;
        scoreCardObj.designations__c=cardDesignations;
 
        insert scoreCardObj;
        return scoreCardObj;
    }
}