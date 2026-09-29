public with sharing class schemaClass {
    public static void GetObjects() {
        Map<String, Schema.SObjectType> globalDescribe = Schema.getGlobalDescribe();
        for(String objectName : globalDescribe.keySet()) {
            Map<String, Schema.SObjectField> fieldMap = globalDescribe.get(objectName).getDescribe().fields.getMap();
            System.debug('Object Name: ' + objectName);
            for (String fieldName : fieldMap.keySet()) {
                System.debug('Field Name: ' + fieldName);
            }
        }
    }
}