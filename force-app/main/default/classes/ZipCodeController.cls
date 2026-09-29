public class ZipCodeController {
    public String countryName {get; set;}
    public String postalPinCode {get; set;}
    public Map<String, Object> jsonMap {get; set;}

    public void search() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('http://api.zippopotam.us/' + countryName + '/' + postalPinCode);
        request.setMethod('GET');

        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            jsonMap = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        }
    }
        class Place{
            public string placeName;
            public string longitude;
            public string state;
            public string stateAbbreviation;
            public string latitude;
    }

        class Address{
            public string postCode;
            public string country;
            public string countryAbbreviation;
            public List<Place> places;
          }
    }