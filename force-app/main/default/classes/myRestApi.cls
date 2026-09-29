@RestResource(urlMapping='/learnApi/')
//there are following type of annotations in Rest Api
//@RestResource(urlMapping='/yourURLNameHere/') :This annotation is used at the beginning of your apex
// class which allows a third party system to hit this URL.
//@RestDelete
//@HttpGet
//@HttpPatch
//HttpPost
//@HttpPut

Global class myRestApi {
    //@HttpGet
    //global static void postDat(){}
    
    //@httpPost
    //global static void postData(){}        
    
   // @httpPut
    //global static void PutData(){}
   // @HttpDelete
    //global static void deleteData(){}
    @HttpGet
    global static Product2 getProducts(){
        Product2 prod=new Product2();
        map<string, string>paramsMap=RestContext.request.params;
        string prodId=ParamsMap.get('Id');
        prod=[select id,name,Product_code__c from Product2 where id=:prodId];
        return prod;
        
    }
    @HttpDelete
    global static string deleteProducts(){
        product2 prod=new product2();
        map<string, string>paramsMap=RestContext.request.params;
        string prodId=paramsMap.get('Id');
        prod=[select Id,Name,Product_Code__c from Product2 Where Id=:prodId];
        delete prod;
        return 'Product Deletd';
    }
    @HttpPost
    global static Product2 createProducts(string Name,string ProductCode){
        product2 prod=new product2();
        prod.Name=Name;
        prod.Product_Code__c=ProductCode;
        insert prod;
        return prod;
    }
    @HttpPut
    global static Product2 updateProducts(String Name,String ProductCode){
        Map<string, string>paramsMap=RestContext.request.params;
        string prodId=paramsMap.get('Id');
        product2 prod=new product2();
        prod.Id=prodId;
        prod.Name=Name;
        prod.Product_Code__c=productCode;
        update prod;
        return prod;
        
    }
    

}