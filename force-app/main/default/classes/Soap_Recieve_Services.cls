global class Soap_Recieve_Services {
    webService static String callMe(String name,String phone ,String industry){
        DOM.Document doc = New DOM.Document();
        DOM.XmlNode root =doc.createRootElement('result',null,null);
        try{
            Account acc =new Account();
                acc.Name=name;
                acc.Phone=phone;
                acc.Industry=industry;
                insert acc;
            DOM.XmlNode status=root.addChildElement('Status',null,null);
            status.addTextNode('Success');
            DOM.XmlNode inode=root.addChildElement('ID',null,null);
            status.addTextNode(''+acc.ID);  
        }
        catch(exception e){
            DOM.XmlNode status=root.addChildElement('Status',null,null);
            status.addTextNode('Failed');
            DOM.XmlNode inode=root.addChildElement('ID',null,null);
            status.addTextNode(e.getMessage());  
        }

        String result = doc.toXmlString();
        return result;
    }
}