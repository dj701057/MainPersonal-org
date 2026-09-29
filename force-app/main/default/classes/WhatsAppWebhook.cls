@RestResource(urlMapping ='/whatsapp/webhooks/v1/*')
Global class WhatsAppWebhook {
	private static Final string SIGNATRE_VALID_MESSAGE ='Signature Verified';
    private static Final string SIGNATRE_NOT_VALID_MESSAGE ='Signature could not be Verified';
    @HttpGet
    global static void doGet(){
        RestResponse response = RestContext.response;
        RestRequest request = RestContext.request;
        if(request.params.get('hub.verify_token')==System.Label.WHATSAPPTOKEN){
            response.responseBody = Blob.valueOf(request.params.get('hub.challenge'));
        }
    }
}