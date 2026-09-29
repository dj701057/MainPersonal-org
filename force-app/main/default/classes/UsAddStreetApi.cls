public class UsAddStreetApi {
    public static void UsAddressStreetApi(){
        Http h=new HTTP();
        HTTPRequest req=new HTTPRequest();
        req.setEndpoint('https://us-street.api.smartystreets.com/street-address?key=21102174564513388');
        req.setMethod('Get');
        HTTPResponse res=h.send(req);
        Map<string,object>Jsonbody=(map<string,object>)json.deserializeUntyped(res.getBody());
        system.debug('Jsonbody');
        Map<string,object>Address =(Map<string,object>)jsonbody.get('Address');
   }

}