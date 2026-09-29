public class DynamicSearchAccountRecordsController {
    public string searchText{get;set;}
    public List<Account> lst{get;set;}
    public void searchAccountRecords(){
        lst=new List<Account>();
       if(searchText !=null && searchText !='')
           {
               searchText +='%';
               lst=[select id,name,rating,industry,phone from Account where name like:searchText];
            }
            else{
                    ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.info,'Please Enter the Search text' ));
                }
    } 
}