public class Currencyconvertor {
    public static void  CurrencyconvertorfromEUROtoINR(){
        decimal inr=0.0;
        Http h=new HTTP();
        HTTPRequest req=new HTTPRequest();
        req.setEndpoint('http://data.fixer.io/api/latest?access_key=07c2b8d9c9815218322a140f98c56725');
        req.setMethod('GET');
        HTTPResponse res=h.send(req);
        if(res.getStatusCode()==200){
             Map<string,object>Jsonbody=(map<string,object>)json.deserializeUntyped(res.getBody());
             system.debug('Jsonbody'+Jsonbody);
             Map<string,object>rates=(Map<string,object>)jsonbody.get('rates');
             system.debug('Rates:-'+rates);
            
        }
       // Map<string,object>Jsonbody=(map<string,object>)json.deserializeUntyped(res.getBody());
        //system.debug('Jsonbody'+Jsonbody);
       // Map<string,object>rates=(Map<string,object>)jsonbody.get('rates');
        //decimal conversionrate=(decimal)rates.get('INR');
        //inr=eur * conversionrate;
        //return inr;
    }

}