global class ContactBatch implements database.Batchable<sobject>{
    global Database.QueryLocator start(Database.BatchableContext bc){
        string Query='select id,Name,Fax,Email,MobilePhone,Description,Account.Name,Account.Rating,Account.Phone,Account.Fax,Account.Industry from Contact';
        return Database.getQueryLocator(Query);
    }
    global void execute(Database.BatchableContext bc,List<Contact>contactList){
     integer size=contactList.size();
        for(integer i=0;i<size;i++){ 
            Contact con =contactList.get(i);
            if(con.Fax == null ){
                con.Fax=con.Account.Fax;
            }
            if(con.MobilePhone==null){
                con.MobilePhone=con.Account.Phone;
            }
            con.Email='dj701078@gmail.com';
            con.Description=con.Account.Name+' '+con.Account.Industry+' '+con.Email;
        }
        update contactList;
    }
    global void finish(Database.BatchableContext bc){
        Messaging.SingleEmailMessage email=new Messaging.SingleEmailMessage();
        email.setSubject('Status of batch class:ContactBatch');
        email.setSenderDisplayName('Deepak jaiswal');
        email.setHtmlBody('Dear user Batch Processed');
        list<string> emailTo=new List<string>();
        emailTo.add('dj701078@gmail.com');
        email.setToAddresses(emailTO);
        
        Messaging.SingleEmailMessage[] emailList=new List<Messaging.SingleEmailMessage>();
        Messaging.sendEmail(emailList, false);
        
    
    }

}