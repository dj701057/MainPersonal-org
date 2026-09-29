public with sharing class AccountListCtrl {
    @AuraEnabled
    public static list<Account> fetchAccounts(){
        return [SELECT Id, Name, Type, Phone, Industry, AccountNumber FROM Account];
    }
    @AuraEnabled
    public static Contact submitScoreAction(string cardFirstName, string cardLastName, string cardEmail, string cardPhone, id accId){
        Contact conCardObj = new Contact();
        conCardObj.FirstName=cardFirstName;
        conCardObj.LastName=cardLastName;
        conCardObj.Email=cardEmail;
        conCardObj.Phone=cardPhone;
        conCardObj.AccountId = accId;
        insert conCardObj;
        return conCardObj;
              
    }

    @AuraEnabled(cacheable=true)
     public static List < customValueWrapper > SubjectPicklist(sObject uiObjectInfoApi, string selectPicklistApi) {
        Schema.DescribeSObjectResult objDescribe = uiObjectInfoApi.getSObjectType().getDescribe();     
        map < String, Schema.SObjectField > customFieldMap = objDescribe.fields.getMap();      
        list < Schema.PicklistEntry > custPickValues = customFieldMap.get(selectPicklistApi).getDescribe().getPickListValues();
        list < customValueWrapper > customObjWrapper = new list < customValueWrapper > ();
        for (Schema.PicklistEntry myCustPick: custPickValues) {
          customValueWrapper selectOptionValueWrapper = new customValueWrapper();
             selectOptionValueWrapper.custFldlabel = myCustPick.getLabel();
             selectOptionValueWrapper.custFldvalue = myCustPick.getValue();
            customObjWrapper.add(selectOptionValueWrapper);
        }
        
        return customObjWrapper;
  
    }

    @AuraEnabled(cacheable=true)
     public static List < customValueWrapper > StatusPicklist(sObject uiObjectInfoApi, string selectPicklistApi) {
        Schema.DescribeSObjectResult objDescribe = uiObjectInfoApi.getSObjectType().getDescribe();     
        map < String, Schema.SObjectField > customFieldMap = objDescribe.fields.getMap();      
        list < Schema.PicklistEntry > custPickValues = customFieldMap.get(selectPicklistApi).getDescribe().getPickListValues();
        list < customValueWrapper > customObjWrapper1 = new list < customValueWrapper > ();
        for (Schema.PicklistEntry myCustPick: custPickValues) {
          customValueWrapper selectOptionValueWrapper = new customValueWrapper();
             selectOptionValueWrapper.custFldlabel1 = myCustPick.getLabel();
             selectOptionValueWrapper.custFldvalue1 = myCustPick.getValue();
            customObjWrapper1.add(selectOptionValueWrapper);
        }
        
        return customObjWrapper1;
  
    }

    @AuraEnabled(cacheable=true)
     public static List < customValueWrapper > PriorityPicklist(sObject uiObjectInfoApi, string selectPicklistApi) {
        Schema.DescribeSObjectResult objDescribe = uiObjectInfoApi.getSObjectType().getDescribe();     
        map < String, Schema.SObjectField > customFieldMap = objDescribe.fields.getMap();      
        list < Schema.PicklistEntry > custPickValues = customFieldMap.get(selectPicklistApi).getDescribe().getPickListValues();
        list < customValueWrapper > customObjWrapper2 = new list < customValueWrapper > ();
        for (Schema.PicklistEntry myCustPick: custPickValues) {
          customValueWrapper selectOptionValueWrapper = new customValueWrapper();
             selectOptionValueWrapper.custFldlabel2 = myCustPick.getLabel();
             selectOptionValueWrapper.custFldvalue2 = myCustPick.getValue();
            customObjWrapper2.add(selectOptionValueWrapper);
        }
        
        return customObjWrapper2;
  
    }
      // wrapper class 
        public with sharing class customValueWrapper {
          @auraEnabled public string custFldlabel {get;set;}
          @auraEnabled public string custFldvalue {get;set;}
          @auraEnabled public string custFldlabel1 {get;set;}
          @auraEnabled public string custFldvalue1 {get;set;}
          @auraEnabled public string custFldlabel2 {get;set;}
          @auraEnabled public string custFldvalue2 {get;set;}
          
        }

    @AuraEnabled
    public static Task newTaskCreated(string subjectPick, string statusPick, String priorityPick, id accId){
        Task TaskObj = new Task();
        TaskObj.Subject = subjectPick;
        TaskObj.Status = statusPick;
        TaskObj.Priority =priorityPick;
        TaskObj.WhatId = accId;
        insert TaskObj;
        return TaskObj;
              
    }
    
}