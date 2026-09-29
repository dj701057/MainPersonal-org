trigger Duplicate_Lead_Trigger on Lead (before insert, after insert) {
     Duplicate_Lead.afterInsert(Trigger.new);

}