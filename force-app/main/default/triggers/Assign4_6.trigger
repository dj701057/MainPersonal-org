trigger Assign4_6 on Lead (after update) {
    //Lead myLead = trigger.new[0];
    for (Lead l: trigger.new){
        if (l.LeadSource =='Phone Inquary') {
        Database.LeadConvert lc = new database.LeadConvert();
        lc.setLeadId(l.Id);
        }
    update l;
}

}