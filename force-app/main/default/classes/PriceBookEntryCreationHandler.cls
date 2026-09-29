public class PriceBookEntryCreationHandler {
    public static void createPriceBookEntry(list<product2>pList){
        set<Id>ProductIds=new set<Id>();
        list<String>Currencies=new list<String>();
        map<String,Id>CurrencyvsProductId=new map<String,Id>();
        list<CurrencyType>CurrencyList=[SELECT Id, ConversionRate,IsoCode FROM CurrencyType]; 
        for(CurrencyType c:CurrencyList){
            Currencies.add(c.IsoCode);
        }
        System.debug('CurrencyList'+CurrencyList);
        Pricebook2 pb=[SELECT Id, IsDeleted, Name, CurrencyIsoCode,IsActive, IsStandard FROM Pricebook2 where IsStandard=true ];
        list<PricebookEntry>pbeListToBeCreated=new list<PricebookEntry>();
        for(product2 p:pList){
            if(p.IsActive == true){
                for(string c:Currencies){
                    String currencyCodeWithProductId=c+p.id;
                    ProductIds.add(p.id);
                    CurrencyvsProductId.put(currencyCodeWithProductId,p.id);
                }
            }
            
        }        
        List<product2>ProductListWithRecordTypes=[SELECT Id, Name, ProductCode, Description, IsActive, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, Family, CurrencyIsoCode FROM Product2 ];        
        system.debug('ProductIds'+ProductIds);
        list<PricebookEntry>pbeThatAlreadyExists =[SELECT Id, Name, Pricebook2Id, Product2Id, CurrencyIsoCode, UnitPrice, IsActive, UseStandardPrice, ProductCode, IsDeleted FROM PricebookEntry WHERE Product2Id IN:CurrencyvsProductId.Values() AND CurrencyIsoCode IN:Currencies];
        system.debug('pbeThatAlreadyExists'+pbeThatAlreadyExists);
        
        for(string c:CurrencyvsProductId.keyset()){
            string currCode=c.replaceAll('\\d', '');
            System.debug('currCode'+currCode);
            system.debug('pbeThatAlreadyExists'+pbeThatAlreadyExists);
            PricebookEntry pbe1=new PricebookEntry();
            pbe1.Pricebook2Id=pb.id;
            pbe1.Product2Id=CurrencyvsProductId.get(c);
            pbe1.CurrencyIsoCode=currCode;
            pbe1.UnitPrice=1;
            if(!pbeThatAlreadyExists.contains(pbe1)){
                pbeListToBeCreated.add(pbe1);
            }
        }
        system.debug('pbeListToBeCreated'+pbeListToBeCreated);
        insert pbeListToBeCreated;
    }
}