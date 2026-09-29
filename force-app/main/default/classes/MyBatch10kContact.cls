global class MyBatch10kContact implements Database.Batchable<sObject> {
    global Database.QueryLocator start(Database.BatchableContext BC){
        String query = 'SELECT Id, Name FROM Account LIMIT 2';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<Account> accList){
        List<Id> accountIds = new List<Id>();
        for (Account acc : accList) {
            accountIds.add(acc.Id);
        }

        System.enqueueJob(new InsertContactsQueueable(accountIds));
    }

    public void finish(Database.BatchableContext bc){
        List<messaging.SingleEmailMessage> listEmail = new List<messaging.SingleEmailMessage>();
        messaging.SingleEmailMessage email = new messaging.SingleEmailMessage();
        List<String> param1 = new List<String>();
        param1.add('satyanshu@astreait.com');
        email.setToAddresses(param1);
        email.setSubject('10K Record Inserted');
        String body = 'Hey, 10000 record have been successfully added to Account';
        email.setHtmlBody(body);
        listEmail.add(email);
        Messaging.sendEmail(listEmail);
    }
}