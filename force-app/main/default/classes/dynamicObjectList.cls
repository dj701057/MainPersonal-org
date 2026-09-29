public with sharing class dynamicObjectList {
   
    @AuraEnabled(cacheable=true)
   public static List<FieldDefinition> getfields(string objectname){
       string query = 'select DeveloperName,QualifiedApiName from FieldDefinition where EntityDefinition.QualifiedApiName = :objectname ORDER BY DeveloperName ASC';
       list<FieldDefinition> lstObject = Database.query(query);
       system.debug('lstObject==> '+lstObject);
       for(Integer i=0;i<lstObject.Size();i++){
           system.debug('lstObject==> '+lstObject[i].QualifiedApiName);
       }
       return lstObject;
   }
}