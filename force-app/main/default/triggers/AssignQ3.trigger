//Q4 Prevent deletion of account if it has any open opportunity related to it, along with an error message.
trigger AssignQ3 on Account (After delete) {
    for(Account a:Trigger.new){
        Opportunity opp=new Opportunity();
        if(a.id==opp.account.id){
            if(opp.StageName=='Closed Won' || opp.StageName=='Closed Lost'){
            delete a;
            }
}
else{
a.addError('You cant delete this account');
}
}
}