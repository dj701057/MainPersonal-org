public class GetAllObjectRecordCountOnMap {
    public String selectedObject { get; set; }
    public Integer recordCount { get; set; }
    
    public List<SelectOption> getObjectOptions() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('', '-- Select --'));
        
        Integer limits = 999;
        Integer count = 0;
        
        for (Schema.SObjectType objType : Schema.getGlobalDescribe().values()) {
            if (count < limits) {
                options.add(new SelectOption(objType.getDescribe().getName(), objType.getDescribe().getLabel()));
                count++;
            } else {
                break; 
            }
        }
        return options;
    }
    
    /*public void updateRecordCount() {
        if (selectedObject != null && selectedObject != '') {
            system.debug('sdkheiwhdihwidh');
            String query = 'SELECT COUNT() FROM ' + selectedObject ;
            recordCount = Database.countQuery(query);
            system.debug('recordCount'+recordCount);
        } else {
            recordCount = 0;
        }
    }*/
    public void updateRecordCount() {
        String query = 'SELECT COUNT() FROM ' + selectedObject;
        recordCount = Database.countQuery(query);
    }
}