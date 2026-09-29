public class getAllObject {
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