@RestResource(URLmapping='/EventRecordServices/*')
Global class EventRecordService {
	@HttpGet
	Global static Event GetEventDetailsById()
    {
        Map<string,string> mapInputs =RestContext.request.Params;
        Event EventRecords =[SELECT Id, Subject,StartDateTime,EndDateTime,Location,OwnerId,CreatedById,ActivityDate,Description,IsReminderSet,
                            What.Type, whatId FROM Event Where id=:mapInputs.get('Id')] ;
            
        return EventRecords;
    }
}