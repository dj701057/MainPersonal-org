public class testobject {
    @AuraEnabled(cacheable=true)
    public static Map<String, String> getSObjects() {        
        Map<String, String> sObjectNamebyLabel = new Map<String, String>();
        for(SObjectType objectType : Schema.getGlobalDescribe().values()) {
            DescribeSObjectResult sObjectDescribe = objectType.getDescribe();
            if(sObjectDescribe.isAccessible() && sObjectDescribe.isQueryable()) {
                sObjectNamebyLabel.put(sObjectDescribe.getLabel(),sObjectDescribe.getName());
            }
        }        
        return sObjectNamebyLabel;
    }

}