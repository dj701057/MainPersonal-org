public class MessagingHelper {
    public static void CreateLeadRecordManualy(){
        List<Lead> leadRecords = new List<Lead>();
        	//First lead Record
        	Lead ld = new Lead();
        	ld.FirstName = 'Deepak';
            ld.LastName = 'Jaiswal';
            ld.Email = 'dj701058@gmail.com';
            ld.Rating = 'Hot';
            ld.Industry = 'Technology';
            ld.AnnualRevenue = 10000000;
            ld.Company = 'Abc';
            ld.State = 'Open';
        leadRecords.add(ld);
        //Second Lead Record
        Lead ld1 = new Lead();
        	ld1.FirstName = 'Deepak1';
            ld1.LastName = 'Jaiswal1';
            ld1.Email = 'dj701057@gmail.com';
            ld1.Rating = 'Hot';
            ld1.Industry = 'Technology';
            ld1.AnnualRevenue = 10000000;
            ld1.Company = 'Abcd';
            ld1.State = 'Open';
        leadRecords.add(ld1);
        //Third Lead Record
        Lead ld2 = new Lead();
        	ld2.FirstName = 'Deepak2';
            ld2.LastName = 'Jaiswal2';
            ld2.Email = 'dj701078@gmail.com';
            ld2.Rating = 'Hot';
            ld2.Industry = 'Technology';
            ld2.AnnualRevenue = 10000000;
            ld2.Company = 'Abcde';
            ld2.State = 'Open';
        leadRecords.add(ld2); 
        if(! leadRecords.isEmpty()){
			 insert leadRecords;
            //Invoke the Method to send the Email ALert..
            SendEmailNotificationAlerat(leadRecords);
        }
    }
    
    public static void SendEmailNotificationAlerat(List<Lead> lstLeads){
		if(!lstLeads.isEmpty())
        {
            List<Messaging.SingleEmailMessage> lstEmailAlerts = new List<Messaging.SingleEmailMessage>();
			For(Lead ldRecord : lstLeads)
            {
                //Prepare the email Notification
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                string [] toaddress =new string[]{ldRecord.Email,'dj701058@gmail.com'};
                    email.setToAddresses(toaddress);
                	email.setReplyTo('Support@dell.com');
                	email.setSenderDisplayName('Learn Email Messaging');
                email.setSubject('Congratulations!'+ldRecord.FirstName+' '+ldRecord.LastName+'... You have learn Email messaging succesfully');
                string emailContent ='Dear'+ldRecord.FirstName+' '+ldRecord.LastName+ '<br/> <br/>'+ 'We pleased to inform you that you have been  Learn Email Messaging from Apex'+
                    										'Here are the Lead Deatils :<br/> <br/>'+
                    										'Lead Record ID :'+ldRecord.Id+
                    										'<br/>Lead Person Name ->'+ldRecord.FirstName + ldRecord.LastName+
                    										'<br/> Lead Rating ->'+ldRecord.Rating;
                email.setHtmlBody(emailContent);
                //Prepare the Attachments
                Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
                	attach.setFileName(ldRecord.FirstName + ' ' + ldRecord.LastName+ '.pdf');
                	attach.setContentType('Application/pdf');
                	attach .body =Blob.toPdf(emailContent);
                
                List<messaging.EmailFileAttachment> lstAttachments = new List<Messaging.EmailFileAttachment>();
                	lstAttachments.Add(attach);
                
                //Add the Attachment to the email..
                email.setFileAttachments(lstAttachments);
                //Add the Email Aleart to the collection..
                lstEmailAlerts.Add(email);
            }
            if(! lstEmailAlerts.isEmpty())
            {
				Messaging.SendEmailResult[] results = Messaging.sendEmail(lstEmailAlerts,false);	
            }
        }
    }
    
    //Automatic Lead generation
        public static void createLeadsAndSendEmail() {
        List<Lead> leads = new List<Lead>();
        for (Integer i = 0; i < 3; i++) {
            leads.add(new Lead(FirstName = 'Lead ' + i, LastName = 'Record ' + i, Company = 'Test Company ' + i));
        }
        insert leads;

        // Create the email
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(new List<String>{leads[0].Email, leads[1].Email, leads[2].Email});
        email.setSubject('Test email with PDF attachment');
        email.setPlainTextBody('This is a test email with a PDF attachment.');

        // Create the PDF
        PageReference pdf = new PageReference('/apex/MyPDF');
        Blob pdfBlob = pdf.getContentAsPDF();
        Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
        attachment.setFileName('test.pdf');
        attachment.setBody(pdfBlob);
        email.setFileAttachments(new Messaging.EmailFileAttachment[] { attachment });

        // Send the email
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
    }
}