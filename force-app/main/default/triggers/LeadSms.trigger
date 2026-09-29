trigger LeadSms on Lead (after insert) {
	Map<id,Lead>lm =Trigger.newMap;
    set<id> keys =lm.keySet();
    RealTimeLeadToSms.SendMessage(keys);
}