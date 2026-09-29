@RestResource(urlMapping='/CreateAccount/*')
global class Rest_Recieve_Services {
    @HttpPost
    global static String callMe(String name,String phone ,String industry){
        System.JSONGenerator js = JSON.CreateGenerator(TRUE);
        js.WriteStartObject();
        try{
            Account acc =new Account();
            acc.Name=name;
            acc.Phone=phone;
            acc.Industry=industry;
            insert acc;
            js.WriteStringField('Status','Success');
            js.WriteStringField('AccountId',acc.ID);   
        }
        catch(exception e){
            js.WriteStringField('Status','Failed');
            js.WriteStringField('AccountId',e.getMessage());
        }

        js.WriteEndObject();
        String result = js.getAsString();
        return result;
    }

    @HttpGet
    global static String invoke(){
        RestRequest request = RestContext.request;
        Map<String, String> UrlMap = request.params;
        System.JSONGenerator js = JSON.CreateGenerator(TRUE);
        js.WriteStartObject();
        try{
            Account acc =new Account();
            acc.Name=UrlMap.get('name');
            acc.Phone=UrlMap.get('phone');
            acc.Industry=UrlMap.get('industry');
            insert acc;
            js.WriteStringField('Status','Success');
            js.WriteStringField('AccountId',acc.ID);   
        }
        catch(exception e){
            js.WriteStringField('Status','Failed');
            js.WriteStringField('AccountId',e.getMessage());
        }

        js.WriteEndObject();
        String result = js.getAsString();
        return result;
    }

}