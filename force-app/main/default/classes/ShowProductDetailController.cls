public class ShowProductDetailController {
    Public integer productCode {get;set;}
    Public string productName {get;set;}
    Public string ManufactureName{get;set;}
    Public Decimal unitPrice{get;set;}
    Public Date manufacturingDate{get;set;}
    Public Date expiryDate{get;set;}
    
    public ShowProductDetailController (){
        productCode =123;
        productName ='abc';
        ManufactureName='xzz';
        unitPrice=12.034;
        manufacturingDate=system.Today();
        expiryDate=system.Today().AddYears(1);
        }
}