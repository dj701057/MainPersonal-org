public with sharing class ChatNewLead {
    public class chatBotLeadInput{
        @InvocableVariable(required=true)
        public string phone;
        @InvocableVariable(required=true)
        public string servicetype;
        @InvocableVariable(required=true)
        public string firstname;
        @InvocableVariable(required=true)
        public string lastname;
       
        
    }
    @InvocableMethod(label='Create a Lead' description='Create a Lead from Chatbot')
    public static void makeLead(List<ChatBotLeadInput> inputs){
        List<Lead>newLeads=new List<Lead>();
        for(ChatBotLeadInput i : inputs){
            Lead chatlead=new Lead ();
            chatlead.FirstName=i.firstname;
            chatlead.LastName=i.lastname;
            chatlead.Phone=i.phone;
            //chatlead.Service_Type__c=i.servicetype;
            chatlead.Company='Voldy bot Lead';
            chatlead.LeadSource='ChatBot';
            //chatlead.OwnerId =Label.BotLeads;
            newLeads.add(chatlead);
        }
        insert newLeads;
    }

}