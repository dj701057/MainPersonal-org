public class budgetConfigurations {
	@AuraEnabled(cacheable=true)
    public static Wrapper fetchDetails(){
       	Wrapper wrapperData = new Wrapper();
        List<List<String>> optionsData = new List<List<String>>();
        List<Schema.DescribeFieldResult> pickListFieldOptions = new List<Schema.DescribeFieldResult>();
        
        Schema.DescribeSObjectResult accountDescribe = Account.sObjectType.getDescribe();
		
        pickListFieldOptions.add(accountDescribe.fields.getMap().get('Client_Rating__c').getDescribe());    
		pickListFieldOptions.add(accountDescribe.fields.getMap().get('Trade_Category__c').getDescribe());    
		pickListFieldOptions.add(accountDescribe.fields.getMap().get('Industry').getDescribe());    
		pickListFieldOptions.add(accountDescribe.fields.getMap().get('State__c').getDescribe());  
        
        for(Schema.DescribeFieldResult itr:pickListFieldOptions){
            List<String> picklistOptions = new List<String>();
            if (itr.getType() == Schema.DisplayType.PICKLIST) {
                List<Schema.PicklistEntry> picklistValues = itr.getPicklistValues();
                for (Schema.PicklistEntry picklistEntry : picklistValues) {
                    String value = picklistEntry.getValue();
                    picklistOptions.add(value);
                }
                picklistOptions.add('Total');
				optionsData.add(picklistOptions);
            }
        }
        wrapperData.userRecords = [SELECT Id, Name FROM User];
		wrapperData.clientRatingOptions = optionsData[0];
		wrapperData.tradeCategoryOptions = optionsData[1];
		wrapperData.industryOptions = optionsData[2];
		wrapperData.stateOptions = optionsData[3];
        return wrapperData;
    }  
    
    
    public class Wrapper {
        @AuraEnabled
        public List<User> userRecords { get; set; }
        @AuraEnabled
        public List<String> clientRatingOptions { get; set; }
        @AuraEnabled
        public List<String> tradeCategoryOptions { get; set; }
        @AuraEnabled
        public List<String> industryOptions { get; set; }
        @AuraEnabled
        public List<String> stateOptions { get; set; }
    }
    
}