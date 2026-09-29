public class fetchData {

@AuraEnabled//Method to get the List of All Objects
public static Map<String, String> getAllObject(){

Map<String,String> returnObjectMap = new Map<String,String>();

//Schema.getGlobalDescribe() => return a Map of type Map<String, Schema.SObjectType>
Map<String, Schema.SObjectType> objectMap = Schema.getGlobalDescribe();

//get List of all sObject
List<Schema.SObjectType> objectMapValues = objectMap.Values();
System.debug('All Objects '+ objectMapValues);

//prepare a Map to send Data from Server to Client Side

for(Schema.SObjectType objType : objectMapValues){
String key = objType.getDescribe().getName();
String value = objType.getDescribe().getLabel();
returnObjectMap.put(key,value);
}
System.debug(returnObjectMap);
if(returnObjectMap != null && returnObjectMap.size() > 0){
return returnObjectMap;
}else{
return null;
}
}

@AuraEnabled //Method to get all the fields of a particular Object
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