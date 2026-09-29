@RestResource(URLMapping='/CasesServices')
//declare Global not public
Global class CasesManagerServices {
    @HttpGet
    Global static List<Case> GetAllCaseRecords(){
       List<Case>lstCases= [select id,caseNumber,status,priority,type,origin,
                     			reason,createdDate,subject from Case Order by CreatedDate desc];
        
        return lstCases;
    }
}