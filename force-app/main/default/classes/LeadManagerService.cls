@RestResource(URLMapping='/LeadRecordsService/*')
//declare Global not public
Global class LeadManagerService {
    @HttpGet
    Global static Lead GetAllLeadRecordByI(){
       Map<String,string> inputParams = RestContext.Request.Params; 
        Lead leadRecord = [select id,firstname,lastname,title,industry,rating,
                           annualrevenue,phone,fax,email,
                           status from Lead where id =:inputParams.get('Id')];
        return leadRecord;
             				
        
    }
}