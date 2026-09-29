public class ChatterIntegration {
    
    public static void pullComments() {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://AP27.salesforce.com/services/data/v52.0/chatter/feeds/news/me/feed-elements');
        req.setMethod('GET');
        
        
        req.setHeader('Authorization', 'OAuth ' + UserInfo.getSessionId());
        req.setHeader('Content-Type', 'application/json');
        HttpResponse res = new Http().send(req);
        if (res.getStatusCode() == 200) {
            String responseString = res.getBody();
            system.debug('responseString'+responseString);
        } else {
            System.debug('Error: ' + res.getBody());
        }
    }
    
    
    
    
    
    
    
    
    
    // Method to push a comment to Chatter
    public static void pushComment(String recordId, String commentBody) {
        // Create JSON payload for the comment
        String payload = '{"body": {"messageSegments": [{"type": "Text", "text": "' + commentBody + '"}]}}';
        
        // Make a POST request to Chatter API endpoint to create a comment
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://yourInstance.salesforce.com/services/data/v52.0/chatter/feed-elements/' + recordId + '/capabilities/comments/items');
        req.setMethod('POST');
        
        // Set necessary headers and access token
        req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionId());
        req.setHeader('Content-Type', 'application/json');
        
        // Set the payload
        req.setBody(payload);
        
        // Send the request and handle the response
        HttpResponse res = new Http().send(req);
        if (res.getStatusCode() == 201) {
            // Comment created successfully
            System.debug('Comment created successfully');
        } else {
            // Handle error response
            System.debug('Error: ' + res.getBody());
        }
    }
}