public class Utrace_integration {
    public String ipAddress {set; get;}
    public String body {set; get;}
    public String status {set; get;}
    public UtraceResult result {set; get;} // Add a property to hold the deserialized result
    
    public class UtraceResult {
        public String ip {set; get;}
        public String host {set; get;}
        public String isp {set; get;}
        public String org {set; get;}
        public String region {set; get;}
        public String countrycode {set; get;}
        public Decimal latitude {set; get;}
        public Decimal longitude {set; get;}
        public Integer queries {set; get;}
    }
    
    public void callUtrace() {
        String endpoint = 'http://xml.utrace.de/?query=' + ipAddress;
        Http p = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('GET');
        
        HttpResponse response = p.send(request); 
        body = response.getBody();
        
        // Deserialize XML
        DOM.Document doc = new DOM.Document();
        doc.load(body);
        DOM.XmlNode root = doc.getRootElement();
        DOM.XmlNode resultNode = root.getChildElement('result', null);
        
        result = new UtraceResult();
        result.ip = getChildElementValue(resultNode, 'ip');
        result.host = getChildElementValue(resultNode, 'host');
        result.isp = getChildElementValue(resultNode, 'isp');
        result.org = getChildElementValue(resultNode, 'org');
        result.region = getChildElementValue(resultNode, 'region');
        result.countrycode = getChildElementValue(resultNode, 'countrycode');
        result.latitude = Decimal.valueOf(getChildElementValue(resultNode, 'latitude'));
        result.longitude = Decimal.valueOf(getChildElementValue(resultNode, 'longitude'));
        result.queries = Integer.valueOf(getChildElementValue(resultNode, 'queries'));
    }
    
    private String getChildElementValue(DOM.XmlNode parentNode, String childTagName) {
        DOM.XmlNode childNode = parentNode.getChildElement(childTagName, null);
        return (childNode != null) ? childNode.getText() : '';
    }
}