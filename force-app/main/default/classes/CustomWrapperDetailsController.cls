public class CustomWrapperDetailsController {
    public List<CustomWrapper> lstWrapper{get;set;}
    
    public void selectAllRecords()
    {
        for(CustomWrapper cWrapper : lstWrapper)
        {
            cWrapper .isSelected =true;
        }
    }
    
    public void UnselectAllRecords()
    {
        for(CustomWrapper cWrapper : lstWrapper)
        {
            cWrapper .isSelected =false;
        }
    }
    
    public void GetRecords()
    {
        lstWrapper =new List<CustomWrapper>();
        
        //get record from obj and store to the collection .
        List<Account> lstAccounts =[select id,name,rating,phone,fax,annualrevenue,
                                    industry from Account Order by Name limit 20];
                                    
           //Pass each account record to custom wrapper (CustomWrapper )  ,then it will prepare the custom record   
           for(Account acc : lstAccounts )
           {
              CustomWrapper cWrapper =new CustomWrapper(acc ,false);
              lstWrapper.Add(cWrapper);
           }  
           
           
        
        List<Contact> lstContacts =[select id ,firstName,lastname,title,phone,
                                    fax from Contact  Order by lastName limit 20];
                                    
         //Pass each COntact record to custom wrapper (CustomWrapper )  ,then it will prepare the custom record   
           for(Contact con : lstContacts )
           {
              CustomWrapper cWrapper = new CustomWrapper(con ,false);
              lstWrapper.Add(cWrapper);
           }  
           
           
                                    
         List<Lead> lstLeads =[select id,firstName,lastName,title,phone ,fax,industry,
                                rating from Lead Order by lastName limit 20];  
       
           //Pass each Lead record to custom wrapper (CustomWrapper )  ,then it will prepare the custom record   
           for(Lead ld : lstLeads )
           {
              CustomWrapper cWrapper = new CustomWrapper(ld ,false);
              lstWrapper.Add(cWrapper);
           }                          
    }

}