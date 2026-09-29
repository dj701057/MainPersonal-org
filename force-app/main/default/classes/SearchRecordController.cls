public class SearchRecordController {
    public string searchText{get;set;}
    
    public PageReference GotoSearchResultPage()
    {
        PageReference pgRef = new PageReference('/apex/searchResultPage?sText='+searchText) ;
        return pgRef.SetRedirect(true);
        
     }
}