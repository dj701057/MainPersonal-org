trigger updateContactAddress on Contact (before insert) {
    Set<Id> accountIds = new Set<Id>();
    for (Contact con : trigger.new) {
        if(con.accountId != null)
            accountIds.add(con.accountId);
    }
    if (accountIds.size() > 0) {
        Map<String, Account> AccountsById = new Map<String, Account>(
            [select Id, BillingAddress,BillingStreet, billingstate, BillingCity,billingpostalcode,  BillingCountry, BillingGeocodeAccuracy from Account where Id IN :accountIds]);
        for (Contact c : trigger.new) {
            Account a = AccountsById.get(c.accountId);
            c.mailingStreet = a.billingStreet;
            c.mailingcity = a.billingcity;
            c.mailingstate = a.billingstate;
            c.mailingpostalcode = a.billingpostalcode;
            c.mailingcountry = a.billingcountry;
        }
    }
}