trigger testAcc on Account (before insert) {
    for(Account acc : trigger.new){
        if(acc.Name.Contains('test')){
            acc.adderror('Account name should not contains "Test"');
        }
    }

}