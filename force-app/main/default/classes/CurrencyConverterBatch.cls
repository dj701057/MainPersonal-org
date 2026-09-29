Global class CurrencyConverterBatch {
	Global Database.QueryLocator start(Database.BatchableContext bc)
    {
		string query ='Select id,Amount,INR_Value__c from opportunity';
        return Database.getQueryLocator(query);
    }
    GLobal void Execute(Database.BatchableContext bc,List<Opportunity>Scope)
    { 
    	string url = '';
    }
    Global void Finish(Database.BatchableContext bc)
    {
        
    }
}