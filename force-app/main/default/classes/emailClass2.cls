public class emailClass2 {
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
        Messaging.reserveSingleEmailCapacity(1);
        try {
            messaging.SingleEmailMessage mail = new messaging.SingleEmailMessage();
            mail.setToAddresses(emailDetails.toAddress);
            mail.setCcAddresses(emailDetails.ccAddress);
            mail.setReplyTo('dj701058@gmail.com');
            mail.setSenderDisplayName('Insert Merge Field Response');
            mail.setSubject(emailDetails.subject);
            mail.setHtmlBody(emailDetails.body);
            mail.setEntityAttachments(emailDetails.files);
            Messaging.sendEmail(new List<messaging.SingleEmailMessage>{ mail });
        } catch (exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    Class EmailWrapper {
        public List<String> toAddress;
        public List<String> ccAddress;
        public String subject;
        public String body;
        public List<String> files;
    }

    Class MergeFieldWrapper {
        public String selectedfield;
        public String selectedObject;
        public List<String> toAddress; 
        
    }
    /*@Auraenabled(cacheable=true)
    public static String getMergeFieldValue(String mergeFieldDetailStr)
    {
        List<SObject> mergeFieldValueList = new List<SObject>();
        MergeFieldWrapper mergeFieldDetail = (MergeFieldWrapper) JSON.deserialize(mergeFieldDetailStr, MergeFieldWrapper.class);
        try {
            String query = 'SELECT ' +  mergeFieldDetail.selectedfield + ' FROM ' + mergeFieldDetail.selectedObject + 'LIMIT 1';
            //'SELECT ' +  mergeFieldDetails.selectedfield + ' FROM ' + mergeFieldDetails.selectedObject + ' WHERE Email = ' + mergeFieldDetails.toAddress;
            mergeFieldValueList = Database.query(query);

        } catch (exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        return 'Sucess ';
    }*/

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