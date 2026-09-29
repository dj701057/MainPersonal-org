trigger totalContactsOnAccount on Contact (before insert,after Delete,after update,after undelete) {
    if(trigger.isAfter){
        if(trigger.isInsert ||trigger.isUpdate ||trigger.isUndelete){
            totalCotactHandler.countContacts(trigger.new,trigger.old);
        }
    }

}