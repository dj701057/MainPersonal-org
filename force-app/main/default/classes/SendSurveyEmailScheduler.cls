public class SendSurveyEmailScheduler implements Schedulable {
    
    public void execute(SchedulableContext sc) {
        List<Account> accounts = [SELECT Id, Email__c, Send_Google_Form__c, Data_de_recebimento_do_pedido__c, Last_Survey_Email_Date__c
                                  FROM Account
                                  WHERE Send_Google_Form__c = true AND Data_de_recebimento_do_pedido__c != null AND Last_Survey_Email_Date__c != null];

        List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();

        for (Account acc : accounts) {
            Integer daysSinceLastEmail = math.abs(Date.today().daysBetween(acc.Last_Survey_Email_Date__c));
            System.debug('daysSinceLastEmail'+daysSinceLastEmail);

            if (shouldSendSurveyEmail(daysSinceLastEmail)) {
                String googleFormLink = 'https://docs.google.com/forms/d/1nhRxbvCa7WT4t1MUk8i91R3lPlz8x8pUX6xK7WyBGhY/edit';
                String recipientEmail = acc.Email__c;

                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setToAddresses(new List<String>{recipientEmail});
                email.setSubject('Survey Email');
                email.setPlainTextBody('Please fill out the survey by clicking the link below:\n' + googleFormLink);

                emailList.add(email);
                System.debug('Added email to emailList: ' + email);
            }
        }

        if (!emailList.isEmpty()) {
            Messaging.sendEmail(emailList);
            System.debug('Sent survey emails: ' + emailList);
        }
    }

    private Boolean shouldSendSurveyEmail(Integer daysSinceLastEmail) {
        Set<Integer> intervals = new Set<Integer>{7, 15, 30, 50, 70, 100};
        Integer monthsSinceLastEmail = (daysSinceLastEmail / 30);
        Boolean shouldSend = intervals.contains(daysSinceLastEmail) || (monthsSinceLastEmail >= 12 && Math.mod(monthsSinceLastEmail, 2) == 0);
        System.debug('shouldSendSurveyEmail: ' + shouldSend + ', daysSinceLastEmail: ' + daysSinceLastEmail);
        return shouldSend;
    }
}