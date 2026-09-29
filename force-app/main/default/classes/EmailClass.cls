public with sharing class EmailClass {

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
            mail.setReplyTo('dj701057@gmail.com');
            mail.setSenderDisplayName('Deepak jaiswal');
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
    
    @AuraEnabled(cacheable=true)
    public static List<String> getContactFields(){
        SObjectType contactType = Schema.getGlobalDescribe().get('Contact');
        Map<String,Schema.SObjectField> mfields = contactType.getDescribe().fields.getMap();

        List<String> sObjectDetailsList = new List<String>();
        for(String s : mfields.keySet()){
            sObjectDetailsList.add(String.valueOf(mfields.get(s)));
        }
        return sObjectDetailsList;
    }

        //Method to get objects
        @Auraenabled(cacheable=true)
        public static List<string> getObjects()
        {
            List<string> sObjectList = new List<string>();
            
            for(Schema.SObjectType objTyp : Schema.getGlobalDescribe().Values()){
                String name = objTyp.getDescribe().getName();
                if((!name.containsignorecase('history') && !name.containsignorecase('tag')&&
                    !name.containsignorecase('share') && !name.containsignorecase('feed')) || 
                   name.toLowerCase().right(3) ==  '__c'){      
                       sObjectList.add(name);
                   }
            }
            system.debug('size:'+sObjectList.size());
            return sObjectList;
        }
        
        //Method to get Fields
        @Auraenabled(cacheable=true)
        public static List<FieldWrap> getFields(string objectName)
        {
            Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe(); 
            Schema.SObjectType ctype = gd.get(objectName); 
            Map<String, Schema.SobjectField> fmap = ctype.getDescribe().fields.getMap();   
            List<FieldWrap> strList = new List<FieldWrap>();
            for(String fieldName: fmap.keySet()) {
                FieldWrap wmp = new FieldWrap();
                wmp.name = fieldName;
                wmp.label = fmap.get(fieldName).getDescribe().getLabel();        
                strList.add(wmp);
            }
            return strList;
        }
        
        public class FieldWrap
        {
            @Auraenabled
            public string Name{get;set;}
            @Auraenabled
            public string Label{get;set;}
        }
    
}