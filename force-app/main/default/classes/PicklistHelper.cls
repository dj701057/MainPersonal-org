public with sharing class PicklistHelper {
    public PicklistHelper() {

    }
    @AuraEnabled(cacheable=true)
    public static Map<String,String> getProfiles(){
        Map<String,String> profileMap = new Map<String,String>();
        Map<String,schema.SObjectType> objectMap=schema.getGlobalDescribe();
        List<schema.SObjectType>objectMapValues=objectMap.Values();
        system.debug('All Objects'+objectMapValues);
         for(schema.SObjectType objType :objectMapValues){
            String key = objType.getDescribe().getName();
            String value = objType.getDescribe().getLabel();
            profileMap.put(key,value);
         }
         System.debug(profileMap);
         if(profileMap != null && profileMap.size() > 0){
            return profileMap;
         }
         else{
             return null;
         }
    }   
   
    //Method to get all the fields of a particular Object
    @AuraEnabled 
    public static List<String> getAllfields(String objectName){
    List<String> allFields = new List<String>();
    
    Map<String, Schema.SObjectType> objectMap = Schema.getGlobalDescribe();
    SObjectType objType = objectMap.get(objectName);
    
    // Map of fields with api name and Api name as value
    Map<String,Schema.SObjectField> objTypeFields = objType.getDescribe().fields.getMap();
    if(!objTypeFields.isEmpty()){
        for (String fieldName: objTypeFields.keySet()) {

    //getting labels of the fields
            String fieldLabel = objTypeFields.get(fieldName).getDescribe().getLabel();
            allFields.add(fieldLabel);
        }
    }
    System.debug(allFields);
    return allFields;
    }
    }