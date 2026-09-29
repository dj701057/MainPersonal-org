public class AccountRecordPaginationCOntroller {
    public ApexPages.StandardSetController setController   //Property
    //public ApexPages.StandardSetController setController()  ---> method
    { 
        Get
        {
            if(setController == null)
            {
                //passing the records
                setController = new ApexPages.StandardSetController(Database.getQueryLocator([select id,name, rating, Industry,
                                                                                                annualrevenue,phone,fax from account]));
               }
               return setController; 
        }
        set;    
    }
    public List<Account> getAccounts()
    {
        setController.setPageSize(5);
        return (List<Account>) setController.GetRecords();
    }

}