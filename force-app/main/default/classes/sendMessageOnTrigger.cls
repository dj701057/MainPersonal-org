public class sendMessageOnTrigger{
    @future(callout=true)
    public static void sendMessage(String data){              

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://us-street.api.smartystreets.com/street-address?street=123+main+Schenectady+NY&auth-id=8d497be5-e211-4949-a18f-0bfd1d9970d3&auth-token=th4hargQiuyG7w7L7xfO');
        request.setMethod('GET');
        
        request.setBody(data);
        HttpResponse response = http.send(request);
        System.debug('-------------------------------------->');                
        if (response.getStatusCode() != 200) {
            System.debug('The status code returned was not expected: ' +
                response.getStatusCode() + ' ' + response.getStatus());
        }
        /*else {
            System.debug(response.getBody());
            Map<String, Object> json =
                (Map<String, Object>)
                    JSON.deserializeUntyped(response.getBody());
            if(json.get('responseCode') != 200) {
               
            } 
        }*/
        if(Response.getStatusCode()==200){ 
             List<object> results = (List<object>) JSON.deserializeUntyped(Response.getBody());
             Map<string,object> mapComponents = (Map<string,object>)results[0];
             Map<string,object> components = (Map<string,object>)mapComponents.get('components');
         }
        System.debug('<--------------------------------------');
    }
    
}