//2.Prefix first name with Dr when new Lead is created or updated
trigger PrefixDr on Lead (before insert) {
    for(Lead l:trigger.new){
        l.FirstName='Dr.'+l.FirstName;
    }

}