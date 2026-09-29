public class UpdateAccountFields implements Database.Batchable<sObject>{
    public final String Query;
    public final String Entity;
    public final String Field;
    public final String Value;
    
    public UpdateAccountFields(String q, String e, String f, String v){
        Query=q; Entity=e; Field=f;Value=v;
         system.debug('Query'+Query);
    }
    
    public Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext BC, List<sObject> scope){
        for(Sobject s : scope){
            system.debug('s18'+s);
            s.put(Field,Value); 
            system.debug('s'+s);
        }      
        update scope;
    }
    
    public void finish(Database.BatchableContext BC){
        
    }
    
}