trigger AcctNameUpdateWhenPhoneUpdate on Account (before update) {
    for(Account a:trigger.New){
        if(a.Phone !=trigger.oldmap.get(a.id).Phone){
            a.Name=a.Name+a.Phone;
        }
    }

}