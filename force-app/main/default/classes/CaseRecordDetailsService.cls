@RestResource(URLmapping='/CaseRecordService/*')
Global class CaseRecordDetailsService {
    @HttpGet
	Global static Case GetCaseDetailsById()
    {
        
        Map<string,string> mapInputs =RestContext.request.Params;
        Case csRecord = [select id ,caseNumber,status,priority,origin,reason,
                        subject,description from case
                        						Where id=:mapInputs.get('Id')];
        return csRecord;
    }
}