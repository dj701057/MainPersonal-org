public class searchResultPageController {
    public List<lead> lstLeads{get;set;}
    
     public searchResultPageController()
     {
         lstLeads =new List<Lead>();
         string searchText =ApexPages.CurrentPage().GetParameters().Get('sText');
         
         if(searchText !=null && searchText != '')
         {
             lstLeads =[select id,firstname,lastname,title,industry,rating,annualrevenue,phone
             ,fax,email,status from Lead where lastname like : searchText+'%'];
         }
      }
      
      public PageReference GototSearchPage()
      {
          PageReference pgRef = new PageReference ('/apex/searchRecordPage');
          return pgRef.SetRedirect(true);
       }
}