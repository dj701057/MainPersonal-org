public with sharing class lwcWrapperClassCtrl {
   
    @AuraEnabled(cacheable=true)
    public  static List<WrapperClass>fetchOppData()
    {
       
        List<WrapperClass> wrapperOppList=new List<WrapperClass>();
        for(Opportunity opp:[SELECT Id, Name, Amount, AccountId, Account.Name, CloseDate, Description, StageName, LeadSource,Type FROM Opportunity LIMIT 10])
        {
  
            WrapperClass wrapItemFld=new WrapperClass();
            wrapItemFld.Name=opp.Name;
            wrapItemFld.StageName=opp.StageName;
            wrapItemFld.Description=opp.Description;
            wrapItemFld.LeadSource=opp.LeadSource;
            wrapItemFld.Type=opp.Type;
            wrapperOppList.add(wrapItemFld);
        }
        return wrapperOppList;
    }

    public class WrapperClass
    {
        @AuraEnabled
        public String Name;
        @AuraEnabled
        public String StageName;
        @AuraEnabled
        public String Description;
        @AuraEnabled
        public String LeadSource;
        @AuraEnabled
        public String Type;

    }
}