trigger autoCreateTask on Account (after insert, after update) 
{
    List<Task> insertTask = new List<Task>();
    
    for(Account newAcc : Trigger.new)
    {
        Task newTask = new Task();
        newTask.subject = newAcc.Name;
        newTask.whatId = newAcc.Id;
        newTask.ownerId = newAcc.OwnerId;
        newTask.status = 'In progress';
        newTask.Priority = 'Normal';
        newTask.ActivityDate  = date.today();
        insertTask.add(newTask);
    }
    if(insertTask.size() > 0)
        insert insertTask;
}