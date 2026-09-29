public class IndianPostalBranchesController {
    public string countryName{get;set;}
    Public string postalPinCode{get;set;}
    public string postalResponseJSON{get;set;}
    public List<PostOfficeBranch> lstBranches{get;set;}
    
    public void SearchPostalBranches(){
        lstBranches =new List<PostOfficeBranch>();
        if(postalPinCode !=null && postalPinCode !='')
        {
            string endPointUrl = 'http://api.zippopotam.us/'+countryName+'/' + postalPinCode ;
                        http postalHttp = new Http();
            HttpRequest postalRequest = new HttpRequest();
                postalRequest.setEndpoint(endPointUrl);
                postalRequest.setMethod('GET');
                postalRequest.setTimeout(20000);
            
            HttpResponse postalResponse = postalHttp.send(postalRequest);
                postalResponseJSON = postalResponse.getBody();
           
            //parse the JSON content and reprsenent in tabular formet..
            System.JSONParser pParser = System.JSON.createParser(postalResponse.getBody()) ;
            While(pParser.nextToken()!=null){
                if(pParser.getCurrentToken() == JsonToken.FIELD_NAME && pParser.getText() == 'post code'){
                    pParser.nextToken();
                    system.debug('Json Response Message is ...'+ pParser.getText());
                }
                if(pParser.getCurrentToken() == JsonToken.FIELD_NAME && pParser.getText() == 'country'){
                   // pParser.nextToken();
                    system.debug('Json Response Message is ...'+ pParser.getText());
                }
                if(pParser.getCurrentToken() == JsonToken.FIELD_NAME && pParser.getText() == 'country abbreviation'){
                   // pParser.nextToken();
                    system.debug('Json Response Message is ...'+ pParser.getText());
                }
                if(pParser.getCurrentToken() == JsonToken.FIELD_NAME && pParser.getText() == 'places'){
                    pParser.nextToken();
                    system.debug('Json Response Message is ...'+ pParser.nextToken());
                    if(pParser.getCurrentToken() == JsonToken.START_ARRAY){
                        pParser.nextToken();
                        While(pParser.getCurrentToken() == JsonToken.START_OBJECT){
                           PostOfficeBranch branch = (PostOfficeBranch) pParser.readValueAs(PostOfficeBranch.Class);
                           lstBranches.add(branch);
                            pParser.nextToken();
                        }
                    }
                }
            }
        }
    }
}