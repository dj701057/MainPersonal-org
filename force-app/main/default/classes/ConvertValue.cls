public class ConvertValue {
    
    public static void htmlToValue(){
       List<String> returnList= new  List<String>();
       List <EmailTemplate> emailsValue= [select htmlValue from EmailTemplate];
         system.debug('Line 5------------->'+emailsValue);
        for(EmailTemplate e : emailsValue){
            String s1 = e.htmlValue;
            system.debug('s1' +s1);
            String s2 = s1.stripHtmlTags();
            system.debug('s2' +s2);
            returnList.add(s2);
            system.debug('returnList' +returnList);
        }
    }
}