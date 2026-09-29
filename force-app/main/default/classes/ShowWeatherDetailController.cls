public class ShowWeatherDetailController {
    public string CityName{get;set;}
    public string weatherResponseJSON{get;set;}
    
    //Define the variable to show the value on vf 
    public string humidityValue{get;set;}
    public string pressureValue{get;set;}
    public string feelsLikeTemp{get;set;}
    public string minTemp{get;set;}
    public string maxTemp{get;set;}
    public string AvgTemp{get;set;}
    
    public void GetWeatherDetails()
    {
        // Prepare the required input.
        //string endpointURL = System.Label.WeatherMapEndPoint + CityName + '&appid='+ System.Label.WeatherMapApplicationKey;
        string endpointURL ='https://api.openweathermap.org/data/2.5/weather?q='+CityName+'&appid='+System.Label.WeatherMapApplicationKey;
        system.debug('endpointURL'+endpointURL);
        Http wHttp =new Http();
        
        HttpRequest weatherRequest =new Httprequest();
            weatherRequest.setEndpoint(endpointURL);
            weatherRequest.setMethod('GET');
            weatherRequest.setTimeout(60000);
        
        HttpResponse weatherResponse = wHttp.send(weatherRequest);
        
        weatherResponseJSON = weatherResponse.getBody();
        system.debug('weatherResponseJSON:'+weatherResponseJSON);
        
        //Write the code to parse the JSON Response and Represent on the vf page
        
        System.JSONParser wParser = System.JSON.createParser(weatherResponse.getBody());
        
        While(wParser.nextToken() !=null)
        {
            if(wParser.getCurrentToken() == JsonToken.FIELD_NAME && wParser.getText() =='main' )
                {
                   wParser.nextToken();
                    if(wParser.getCurrentToken() == JsonToken.START_OBJECT )
                    {
                        wParser.nextToken();
                        if(wParser.getCurrentToken() == JsonToken.FIELD_NAME && wParser.getText() =='temp')
                        {
                            wParser.nextToken();
                            AvgTemp = (wParser.getDecimalValue()-273.15)+'C';
                        }
                        wParser.nextToken();
                        if(wParser.getCurrentToken() == JsonToken.FIELD_NAME && wParser.getText() =='feels_like')
                        {
                            wParser.nextToken();
                            feelsLikeTemp = (wParser.getDecimalValue()-273.15)+'C';
                        }
                        wParser.nextToken();
                        if(wParser.getCurrentToken() == JsonToken.FIELD_NAME && wParser.getText() =='temp_min')
                        {
                            wParser.nextToken();
                            minTemp = (wParser.getDecimalValue()-273.15)+'C';
                        }
                        wParser.nextToken();
                        if(wParser.getCurrentToken() == JsonToken.FIELD_NAME && wParser.getText() =='temp_max')
                        {
                            wParser.nextToken();
                            maxTemp = (wParser.getDecimalValue()-273.15)+'C';
                        }
                        wParser.nextToken();
                        if(wParser.getCurrentToken() == JsonToken.FIELD_NAME && wParser.getText() =='pressure')
                        {
                            wParser.nextToken();
                            pressureValue = (wParser.getDecimalValue()-273.15)+'C';
                        }
                        wParser.nextToken();
                        if(wParser.getCurrentToken() == JsonToken.FIELD_NAME && wParser.getText() =='humidity')
                        {
                            wParser.nextToken();
                            humidityValue = (wParser.getDecimalValue()-273.15)+'C';
                        }
                    }
                }
        }
        
        
        
        
        
        
    }
}