public class MapDeepak {
    public static void test(){
        Account acc=[select id,name from Account where name like '%s'];

        Map<Id,contact> contactMap=new Map<Id,contact>([select id,name,AccountId from contact where AccountId=:acc.id]);

        Map<Id,opportunity> oppMap=new Map<Id,opportunity>([select id ,Name from opportunity where AccountId =:acc.id]);

        //Map<Id,Quote> QuoteMap=new Map<Id,Quote>([select id,name from Quote where OpportunityId in: oppMap.values()]);

    }

}