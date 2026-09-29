trigger CreateTaskOnAccount on Account (after insert) {
	List<Task> tasks = new List<Task>();
    for (Account acc : Trigger.new) {
        Task task = new Task();
        task.Subject = acc.Name + ' ' + Date.today();
        task.WhatId = acc.Id;
        tasks.add(task);
    }
    insert tasks;
}