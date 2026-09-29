@isTest
public class CaseRecordDetailsServiceTest {

    @isTest
    static void testGetCaseDetailsById() {
        // Create a test case
        Case testCase = new Case(Status = 'New', Priority = 'High', Origin = 'Phone', Reason = 'Test', Subject = 'Test Case', Description = 'Test Description');
        insert testCase;

        // Call the service method
        Case result = CaseRecordDetailsService.GetCaseDetailsById();

        // Verify the result
        System.assertEquals(testCase.Id, result.Id);
        System.assertEquals(testCase.CaseNumber, result.CaseNumber);
        System.assertEquals(testCase.Status, result.Status);
        System.assertEquals(testCase.Priority, result.Priority);
        System.assertEquals(testCase.Origin, result.Origin);
        System.assertEquals(testCase.Reason, result.Reason);
        System.assertEquals(testCase.Subject, result.Subject);
        System.assertEquals(testCase.Description, result.Description);
    }
}