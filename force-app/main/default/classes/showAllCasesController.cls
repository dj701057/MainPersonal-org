public class showAllCasesController {
    
    public List<case> lstCases{get;set;}
    
    public void GetAllCasesRecords()
    {
        lstCases = new List<case>();
        lstCases = [select id,caseNumber,status,priority,type,origin,
                     reason,createdDate,subject from Case Order by CreatedDate desc];
    }
}