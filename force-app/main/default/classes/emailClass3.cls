public class emailClass3 {
    @AuraEnabled
    public static List<SObject> search(String searchString) {
        List<SObject> searchList = new List<SObject>();
        try {
            String searchStr = '*' + searchString + '*';
            String searchquery =
                'FIND\'' +
                searchStr +
                '\'IN ALL FIELDS RETURNING Contact(id, name, email where email != null), User(id, name, email where email != null AND isActive = true) LIMIT 10';
            List<List<SObject>> searchResult = search.query(searchquery);
            for (List<SObject> curList : searchResult) {
                searchList.addAll(curList);
            }
            system.debug('searchList:::' + searchList.size());
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        return searchList;
    }


    @AuraEnabled
    public static void sendEmailController(String emailDetailStr) {
        EmailWrapper emailDetails = (EmailWrapper) JSON.deserialize(emailDetailStr, EmailWrapper.class);
       
      
      //String newString;
      /*String str=emailDetails.body;
       String expression = '\\{[a-z A-Z]*\\.[a-z A-Z]*\\}';
       String replace = emailDetails.fieldVal;
       String newBody= replace;*/
       //String newBody = regexprep(str,expression,replace);
       
        Messaging.reserveSingleEmailCapacity(1);
        try {
            String expression = '\\{[a-z A-Z]*\\.[a-z A-Z]*\\}';
           // this.newBody = this.body.replace(expression, this.fieldVal);
            //console.log(this.newBody);

            messaging.SingleEmailMessage mail = new messaging.SingleEmailMessage();
           for(integer i=0; i< emailDetails.val2.size(); i++)
            {
            String newBody = emailDetails.body.replaceAll(expression, emailDetails.val2.get(i));
                //String newBody = emailDetails.body.replace(expression, emailDetails.val2.get(0));
                //system.debug(newBody);
                //string mailId=emailDetails.toAddress.get(i);
                //mail.setToAddresses(emailDetails.toAddress.get(i));
                string[] sendTo = new string[]{emailDetails.toAddress.get(i)};
                mail.setToAddresses(sendTo);
            mail.setCcAddresses(emailDetails.ccAddress);
            mail.setReplyTo('test.k@xyz.com');
            mail.setSenderDisplayName('Test'); 
            mail.setSubject(emailDetails.subject);
            mail.setHtmlBody(newBody);
            mail.setEntityAttachments(emailDetails.files);
            Messaging.sendEmail(new List<messaging.SingleEmailMessage>{ mail });
           }
          /* messaging.SingleEmailMessage mail = new messaging.SingleEmailMessage();
            mail.setToAddresses(emailDetails.toAddress);
            mail.setCcAddresses(emailDetails.ccAddress);
            mail.setReplyTo('test.k@xyz.com');
            mail.setSenderDisplayName('Test');
            mail.setSubject(emailDetails.subject);
            mail.setHtmlBody(emailDetails.body);
            mail.setEntityAttachments(emailDetails.files);
            Messaging.sendEmail(new List<messaging.SingleEmailMessage>{ mail });*/
            
        } catch (exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    Class EmailWrapper {
        public List<String> toAddress;
        public List<String> ccAddress;
        public List<String> val2;
        public String subject;
        public String body;
        
        public List<String> files;
    }

    Class MergeFieldWrapper {
        public String selectedfield;
        public String selectedObject;
        public List<String> toAddress; 
        
    }
    

    @Auraenabled
    public static List<sObject> getMergeFieldValue(String mergeFieldDetailStr)
    {
        String query;   
        List<sObject> sObjectList= new list<sObject>();
         
        MergeFieldWrapper mergeFieldDetails = (MergeFieldWrapper) JSON.deserialize(mergeFieldDetailStr, MergeFieldWrapper.class);
        

        List<String> emailList = new List<String>();
        emailList.addAll(mergeFieldDetails.toAddress);
        try {
               
            query = ' SELECT ' +  mergeFieldDetails.selectedfield + ' FROM ' + mergeFieldDetails.selectedObject + ' WHERE Email In : emailList ';
             
            sObjectList = Database.query(query);
                
                
            } catch (exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        return sObjectList;
    }

}