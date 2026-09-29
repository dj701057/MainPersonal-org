public class Emailsend
{

public static void sendingEmail(String cid,String cname,String eventId)
    {
        String plainTxtBody='',startDate='',endDate='',scheduledDate='';
        String hbody='';
        Date sdate;

        //get the email template
        EmailTemplate template=[SELECT HtmlValue,Body FROM EmailTemplate WHERE Name='Email Template test'];
        
        Event eve=[select subject,StartDateTime,EndDateTime,Owner.name,Owner.Email,Owner.Phone 
                    From Event where Id=:eventId];
                    
        hbody=template.HtmlValue;
        
        Contact con = [SELECT Id, firstName from Contact where Id =:cid ];
        
      
        
        //setting the merge fields
        hbody=hbody.replace('{!Contact.firstName}',cname);
        hbody=hbody.replace('{!Event.Subject}',eve.Subject);
         
        plainTxtBody=template.Body;
        plainTxtBody=plainTxtBody.replace(Con.firstName,cname);
       // plainTxtBody=plainTxtBody.replace(Event.Subject,eve.Subject);
        
        //Construct the email message
        Messaging.SingleEmailMessage mail=new Messaging.SingleEmailMessage();
        mail.setTargetObjectId(cid);
        mail.setSaveAsActivity(false);
        mail.setSubject('Meeting Reminder');
        mail.setHtmlBody(hbody);
        mail.setPlainTextBody(plainTxtBody);
        //mail.setTemplateId(template.id);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});     
    }
    }