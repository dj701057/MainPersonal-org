public with sharing class ExploreCustomContactController {
   /* public ExploreCustomContactController() {

    }
    @AuraEnabled(cacheable=true)
    public static List<String> getContactFields(){
        SObjectType contactType = Schema.getGlobalDescribe().get('Contact');
        Map<String,Schema.SObjectField> mfields = contactType.getDescribe().fields.getMap();

        List<String> sObjectDetailsList = new List<String>();
        for(String s : mfields.keySet()){
            sObjectDetailsList.add(String.valueOf(mfields.get(s)));
        }
        return sObjectDetailsList;
    }*/
    @AuraEnabled(cacheable=true)
    public static List<String> getContactFields(String userId){

        List<String> names = new List<String>();

        Map<String,Schema.SObjectType> objMap=Schema.getGlobalDescribe();        
        Schema.SObjectType obj=objMap.get('Contact');        
        Schema.DescribeSObjectResult objResult= obj.getDescribe();      
        Map<String,Schema.SObjectField> fldMap=objResult.fields.getMap();

        for(String s : fldMap.keySet()){
            names.add(String.valueOf(fldMap.get(s)));
        }
        return names;

    }
}