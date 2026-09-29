@isTest
public class EventRecordServiceTest {

    @isTest
    static void testGetEventDetailsById() {
        // Create a test event
        Event testEvent = new Event(Subject = 'Test Event', StartDateTime = DateTime.now(), EndDateTime = DateTime.now().addHours(1), Location = 'Test Location', ActivityDate = Date.today(), Description = 'Test Description', IsReminderSet = true);
        insert testEvent;

        // Call the service method
        Event result = EventRecordService.GetEventDetailsById();

        // Verify the result
        System.assertEquals(testEvent.Id, result.Id);
        System.assertEquals(testEvent.Subject, result.Subject);
        System.assertEquals(testEvent.StartDateTime, result.StartDateTime);
        System.assertEquals(testEvent.EndDateTime, result.EndDateTime);
        System.assertEquals(testEvent.Location, result.Location);
        System.assertEquals(testEvent.OwnerId, result.OwnerId);
        System.assertEquals(testEvent.CreatedById, result.CreatedById);
        System.assertEquals(testEvent.ActivityDate, result.ActivityDate);
        System.assertEquals(testEvent.Description, result.Description);
        System.assertEquals(testEvent.IsReminderSet, result.IsReminderSet);
    }
}