public class InsertContactsQueueable implements System.Queueable {
    List<Id> accountIds;

    public InsertContactsQueueable(List<Id> accountIds) {
        this.accountIds = accountIds;
    }

    public void execute(System.QueueableContext context) {
        List<Contact> conList = new List<Contact>();
        
        for (Id accId : accountIds) {
            Account acc = [SELECT Id, Name FROM Account WHERE Id = :accId];
            for (Integer i = 1; i <= 10000; i++) {
                Contact con = new Contact(LastName = acc.Name + '_Con' + i, AccountId = acc.Id);
                conList.add(con);
            }
        }
        
        insert conList;
    }
}