//When an opportunity is inserted or updated then if the stage name is ‘Closed won’ then add the task.

trigger ClosedOpportunityTrigger on Opportunity (before insert) {
    List<Task> tasklist =New List<Task>();
    for(Opportunity o:[SELECT Id,StageName FROM Opportunity WHERE StageName ='Closed Won' AND Id IN :Trigger.New]){
        if(o.StageName=='Closed won'){
             taskList.add(new task (Subject ='Follow Up Test Task' , WhatId=o.Id));
        }
    }
    if(tasklist.size()>0){
        insert tasklist;
    }
    

}