global class ContactBatchSchedular implements system.Schedulable {
    global void execute(system.SchedulableContext SC){
        ContactBatch batch=new ContactBatch();
        final integer BATCH_SIZE=10;
        //database.executeBatch(batch);
        database.executeBatch(batch,BATCH_SIZE);
        
    }

}