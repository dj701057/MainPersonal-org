trigger AccountEmailer on Account (before insert) {
     if(trigger.isBefore && trigger.isInsert){
        system.debug('i am in AccountEmailer before inseart context');

}
}