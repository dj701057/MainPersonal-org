//public class zipCodeSearch {
public with sharing class zipCodeSearch {
  // Constructor
  public zipCodeSearch() {
    zipValue = 0;
    cityAddr = 'None';
    stateAddr = 'None';
    countryAddr = 'None';
  }

  /* format from ziptasticapi.com:
  {"country":"US","state":"CA","city":"SAN JOSE"}
  */
  // Format returned by ziptastic API
  public class ziptasticReturn {
    string country;
    string state;
    string city;
  }

  public class zipCodeException extends Exception {}
  
  // zipValue property is used by VF page and is the zipcode entered by user
  public integer zipValue {
    get { return zipValue; }
    set { zipValue = value; }
  }

  // stateAddr is a property VF page calls to get the state corresponding to zipValue
  public string stateAddr {
    get { return stateAddr; }
    private set { stateAddr = value; }
  }

  // cityAddr is a property VF page calls to get the city corresponding to zipValue
  public string cityAddr {
    get { return cityAddr; }
    private set { cityAddr = value; }
  }

  // countryAddr is a property VF page calls to get the country corresponding to zipValue
  public string countryAddr {
    get { return countryAddr; }
    private set { countryAddr = value; }
  }

  // Called by commandbutton on VF page to look up the zip code via REST API
  // Returns null so VF page won't navigate to a new page
    public PageReference lookup()
    {
        string resp;
        ziptasticReturn zipInfo;
        //https://geekfeed-search-japanese-postcode-v1.p.rapidapi.com/search-address
        // Note this version of the API is only for the US
        string endpoint ='http://ziptasticapi.com/';
        //string endpoint ='https://ziptasticapi.com/';
        // https://app.zipcodebase.com/api/v1/search?apikey=YOUR-APIKEY&codes=10005%2C51503
        // string endpoint ='https://geekfeed-search-japanese-postcode-v1.p.rapidapi.com/';
        endpoint = endpoint + zipValue;
        system.debug(LoggingLevel.Error,'zipCode.cls: calling endpoint='+endpoint);
        
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http http = new Http();
        req.setMethod('GET');
        req.setEndpoint(endpoint);

    try {
      res = http.send(req);
      if (res.getStatusCode() != 200) {
        throw new zipCodeException(res.getStatus());
      }
    } catch (zipCodeException e) {
      system.debug(LoggingLevel.Error, 'Error HTTP response code = '+res.getStatusCode()+'; calling '+endpoint );
      return null;
    }
  
    resp = res.getBody();
    JSONParser parser = JSON.createParser(resp);
    parser.nextToken(); // Start object "{"
    
    // This convenient method reads the JSON stream into a class in one go
    zipInfo = (ziptasticReturn) parser.readValueAs(ziptasticReturn.class);
    stateAddr = zipInfo.state;
    cityAddr = zipInfo.city;
    countryAddr = zipInfo.country;
    
    return null;
  }
}