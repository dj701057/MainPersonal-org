public class OAuthCallbackController {

    public String message {get;set;}

    public PageReference init() {
        // Retrieve the code parameter from the query string
        String code = ApexPages.currentPage().getParameters().get('code');
        
        return null;
    }

}