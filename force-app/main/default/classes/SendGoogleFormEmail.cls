public class SendGoogleFormEmail {
    @InvocableMethod(label='Send Google Form Email' description='Send email with Google Form link')
    public static void sendEmailWithGoogleFormLink(List<Account> accounts) {
        List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();
		system.debug('accounts'+accounts);
        for (Account acc : accounts) {
            if (acc.Send_Google_Form__c && acc.Email__c != null ) {
                
                //String googleFormLink = 'https://docs.google.com/forms/d/1nhRxbvCa7WT4t1MUk8i91R3lPlz8x8pUX6xK7WyBGhY/edit';
                //String recipientEmail = 'deepakjaiswal@astreait.com'; 
				String recipientEmail=acc.Email__c;
                
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setToAddresses(new List<String>{recipientEmail});
                email.setSubject('Seu diário de bordo - Thronus');

                // Build the email body with the Google Form link
               // String emailBody = 'Please fill out the Google Form by clicking the link below:<br>';
                //emailBody += '<a href="' + googleFormLink + '">Google Form Link</a>';
                /*String emailBody = 'Olá #GeraçãoThronus,<br><br>'
                                    + 'Você tem feito o diário de bordo? Ele é uma ferramenta incrível para acompanhar a evolução do seu tratamento com Bisaliv e mostrar para seu médico ou profissional prescritor. 😃💙<br><br>'
                                    + '"Clique <a href="https://docs.google.com/forms/d/1nhRxbvCa7WT4t1MUk8i91R3lPlz8x8pUX6xK7WyBGhY/edit">Aqui</a> para preencher seu diário de bordo."<br><br>'
                                    + 'Dúvidas durante o tratamento? Podemos te ajudar:<br><br>'
                                    + '- Whatsapp (Link para whatsapp Thronus: <a href="https://wa.me/5511930618162">https://wa.me/5511930618162</a>)<br><br>'
                                    + 'Redes sociais:<br><br>'
                                    + '<a href="https://www.instagram.com/thronus.brasil/?igshid=MzRlODBiNWFlZA%3D%3D">Instagram</a><br>'
                                    + '<a href="https://youtu.be/7ugIGbWS_Qg">YouTube</a><br>'
                                    + '<a href="https://www.linkedin.com/company/thronus-medical/">LinkedIn</a><br>'
                                    + '<a href="https://thronusmedical.com">Website</a>';*/
                
                /*String emailBody = 'Olá #GeraçãoThronus,<br><br>'
                                    + 'Você tem feito o diário de bordo? Ele é uma ferramenta incrível para acompanhar a evolução do seu tratamento com Bisaliv e mostrar para seu médico ou profissional prescritor. 😃💙<br><br>'
                                    + '"Clique <a href="https://docs.google.com/forms/d/1nhRxbvCa7WT4t1MUk8i91R3lPlz8x8pUX6xK7WyBGhY/edit"><b>Aqui</b></a> para preencher seu diário de bordo."<br><br>'
                                    + 'Dúvidas durante o tratamento? Podemos te ajudar:<br><br>'
                                    + '- Whatsapp (Link para whatsapp Thronus: <a href="https://wa.me/5511930618162">https://wa.me/5511930618162</a>)<br><br>'
                                    + 'Redes sociais:<br><br>'
                                    + '<a href="https://www.instagram.com/thronus.brasil/?igshid=MzRlODBiNWFlZA%3D%3D"><img src="https://example.com/instagram_icon.png" alt="Instagram"></a><br>'
                                    + '<a href="https://youtu.be/7ugIGbWS_Qg"><img src="https://www.pngwing.com/en/search?q=youtube" alt="YouTube"></a><br>'
                                    + '<a href="https://www.linkedin.com/company/thronus-medical/"><img src="https://example.com/linkedin_icon.png" alt="LinkedIn"></a><br>'
                                    + '<a href="https://thronusmedical.com"><img src="https://example.com/website_icon.png" alt="Website"></a>';

                email.setHtmlBody(emailBody);*/
                email.setTemplateId('0054x000000FomWAAS'); 

                emailList.add(email);
            }
        }

        if (!emailList.isEmpty()) {
            Messaging.sendEmail(emailList);
        }
    }
}