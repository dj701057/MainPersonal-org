public class Q_class implements Queueable { 
    public void execute(QueueableContext context){
        List<Account>lstToUpdate=new List<Account>();
        for(Account acc:[select id,type from Account where type='Customer-Direct']){
            acc.Type='Prospect';
            lstToUpdate.add(acc);
        }
        if(!lstToUpdate.isEmpty()){
            update lstToUpdate;
        }
        //chaining of jobs
       // Q_class acc=new Q_class();
        //Id=jobId=system.enqueueJob(acc);
    }

}