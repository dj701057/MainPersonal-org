public class SchedulerFlowAction {
    @InvocableMethod(label='Schedule Survey Email' description='Schedules the survey email')
    public static void scheduleSurveyEmail() {
        System.debug('SchedulerFlowAction');
        SendSurveyEmailScheduler scheduler = new SendSurveyEmailScheduler();
        //String cronExpression = '0 0 0 1 * ?';
        String cronExpression = '10 11 * * * ?';
        System.schedule('Send Survey Email', cronExpression, scheduler);
        system.debug('cronExpression-->'+cronExpression);
        system.debug('scheduler-->'+scheduler);
    }
}