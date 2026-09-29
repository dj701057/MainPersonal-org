/**
 * Using class as a controller of the Lib_BaseCtrl, and with some generic methods(Get namespace, get Theme, get employee id, get object permissions like read, create, edit, and delete.).
 */
@namespaceAccessible
public with sharing class Lib_BaseCtrl {
  @AuraEnabled
  public static String getTheme() {
    return UserInfo.getUiThemeDisplayed();
  }

 /* @AuraEnabled
  public static String getUserName(Id userId) {
    Lib_AuraEnabledAccessController.assertAuthorizedToView(
      Schema.User.SObjectType,
      new List<String>{ 'Name' }
    );
    User u = [SELECT Name FROM User WHERE Id = :userId];
    return u.Name;
  }*/
  /*Method to get object name through record id*/
  @AuraEnabled
  public static String getRecordName(Id recordId) {
    if (recordId <> null) {
      String objectApiName = String.valueOf(recordId.getsobjecttype());
      List<Schema.DescribeSObjectResult> describeSobjectsResult = Schema.describeSObjects(
        new List<String>{ objectApiName }
      );
      String objName = describeSobjectsResult[0].getLabel();
      return objName;
    }
    return null;
  }
  /*Method to get heroku configuration from custom setting and custom metadata type*/
 /* @namespaceAccessible
  /*public static void getHerokuConfig(Map<String, Object> r) {
    r.put('herokuURL', getHerokuURL());
    r.put('exportSettings', getExportSettings());
  }*/

 /* @namespaceAccessible
  public static String getHerokuURL() {
    String herokuUrl = Lib_Config.getConfig(Lib_Config.Key.herokuURL);
    return String.IsBlank(herokuUrl)
      ? 'https://nodhom.herokuapp.com/'
      : String.valueOf(herokuUrl);
  }*/

 /* @namespaceAccessible
  public static Map<String, Map<String, Object>> getExportSettings() {
    Map<String, Map<String, Object>> r = new Map<String, Map<String, Object>>();

    for (nodhom__Export_Setting__mdt expSetting : [
      SELECT
        Id,
        DeveloperName,
        nodhom__Property_Value__c,
        nodhom__Value_Type__c,
        nodhom__File_Type__c
      FROM nodhom__Export_Setting__mdt
    ]) {
      Object propertyValue;
      if (expSetting.nodhom__Value_Type__c == 'Integer') {
        propertyValue = Integer.valueOf(expSetting.nodhom__Property_Value__c);
      } else {
        propertyValue = expSetting.nodhom__Property_Value__c;
      }
      if (r.containsKey(expSetting.nodhom__File_Type__c)) {
        r.get(expSetting.nodhom__File_Type__c)
          .put(expSetting.DeveloperName, propertyValue);
      } else {
        r.put(
          expSetting.nodhom__File_Type__c,
          new Map<String, Object>{ expSetting.DeveloperName => propertyValue }
        );
      }
    }
    return r;
  }*/

  /*@AuraEnabled
  public static Map<String, Object> getLocaleInfo() {
    Map<String, Object> r = new Map<String, Object>();

    List<Map<String, String>> locales = new List<Map<String, String>>();
    locales.add(
      new Map<String, String>{ 'value' => 'en_US', 'label' => 'English' }
    );
    locales.add(
      new Map<String, String>{ 'value' => 'ar', 'label' => 'العربية' }
    );
    r.put('lookups', new Map<String, Object>{ 'locales' => locales });

    Lib_AuraEnabledAccessController.assertAuthorizedToView(
      Schema.User.SObjectType,
      new List<String>{ 'LanguageLocaleKey' }
    );
    for (User u : [
      SELECT LanguageLocaleKey
      FROM User
      WHERE Id = :UserInfo.getUserId()
    ]) {
      r.put('data', new Map<String, Object>{ 'locale' => u.LanguageLocaleKey });
    }
    return r;
  }

  @AuraEnabled
  public static Map<String, Object> saveLocaleInfo(String locale) {
    Map<String, Object> r = new Map<String, Object>();

    Map<String, String> locales = new Map<String, String>{
      'ar' => 'ar_SA',
      'en_US' => 'en_US'
    };

    Savepoint sp = DataBase.setSavepoint();
    try {
      Lib_AuraEnabledAccessController.assertAuthorizedToUpdate(
        Schema.User.SObjectType,
        new List<String>{ 'LanguageLocaleKey', 'LocaleSidKey' }
      );
      update new User(
        Id = UserInfo.getUserId(),
        LanguageLocaleKey = locale,
        LocaleSidKey = 'en_GB'
      );
    } catch (Exception e) {
      Database.rollback(sp);
      handleException('Lib_BaseCtrl->saveLocaleInfo()', e);
    }

    return r;
  }

  /**
   * Thorw AuraHandledException with the provided exception.
   * @param  scope Scope value("ClassName->MethodName()").
   * @param  e     Exception object.
   */
 /* @namespaceAccessible
  public static void handleException(String scope, Exception e) {
    handleException(scope, e, true);
  }

  /**
   * Thorw AuraHandledException(if throwAura is true) with the provided exception.
   * @param  scope     Scope value("ClassName->MethodName()").
   * @param  e         Exception object.
   * @param  throwAura Need to throw AuraHandledException or not.
   */
  /*@namespaceAccessible
  public static void handleException(
    String scope,
    Exception e,
    Boolean throwAura
  ) {
    String message = e.getMessage();
    if (e.getTypeName().contains('DmlException')) {
      DmlException dmlException = (System.DmlException) e;
      List<String> errorMessages = new List<String>();
      for (
        Integer dmlExceptionIndex = 0, totalRows = dmlException.getNumDml();
        dmlExceptionIndex < totalRows;
        dmlExceptionIndex++
      ) {
        if (totalRows > 1) {
          errorMessages.add(dmlException.getDmlMessage(dmlExceptionIndex));
        } else {
          errorMessages.add(dmlException.getDmlMessage(dmlExceptionIndex));
        }
      }

      message = String.join(errorMessages, ', ') + '.';
      message = message.replaceFirst('duplicate', 'Duplicate');
      e.setMessage(message);
    } else if (e.getTypeName().contains('SFDCAccessControlException')) {
      SFDCAccessControlException sfdcAccessControlException = (SFDCAccessControlException) e;
      message = sfdcAccessControlException.toString();
      e.setMessage(sfdcAccessControlException.toString());
    }

    NodhomException.logException(scope, e, message);
    if (
      Trigger.isExecuting ||
      System.isBatch() ||
      System.isFuture() ||
      System.isQueueable() ||
      System.isScheduled()
    ) {
      throwAura = false;
    }
    if (throwAura) {
      System.debug('e.getMessage(): ' + e.getMessage());
      AuraHandledException auraHandledException = new AuraHandledException(
        e.getMessage()
      );
      auraHandledException.setMessage(e.getMessage());
      throw auraHandledException;
    }
  }*/

  /*@AuraEnabled
  public static Map<String, Object> fieldSetData(
    String sObjectName,
    String fieldSetName,
    String recordId
  ) {
    List<FieldSetField> fields = getFieldSetFields(sObjectName, fieldSetName);
    SObject data = getRecord(sObjectName, fields, recordId);
    return new Map<String, Object>{ 'fieldsData' => data, 'fields' => fields };
  }

  private static List<FieldSetField> getFieldSetFields(
    String sObjectName,
    String fieldSetName
  ) {
    Schema.SObjectType objectType = null;
    fieldSetName = Lib_NS.Prefix + '__' + fieldSetName;
    if (String.isNotBlank(sObjectName)) {
      objectType = Schema.getGlobalDescribe()
        .get(Lib_NS.namespaceFix(sObjectName));
    }

    Schema.DescribeSObjectResult objectDescribe = objectType.getDescribe();
    Map<String, Schema.FieldSet> fieldSetMap = objectDescribe.fieldSets.getMap();
    Map<String, Schema.SObjectField> allFields = objectDescribe.fields.getMap();
    Schema.FieldSet fieldSet = fieldSetMap.get(fieldSetName);
    List<Schema.FieldSetMember> fieldSetMembers = fieldSet.getFields();
    List<FieldSetField> fields = new List<FieldSetField>();

    for (Schema.FieldSetMember fsm : fieldSetMembers) {
      fields.add(new FieldSetField(fsm, allFields.get(fsm.getFieldPath())));
    }
    return fields;
  }

  private static SObject getRecord(
    String sObjectName,
    List<FieldSetField> fieldSet,
    String recordId
  ) {
    List<String> fieldsToQuery = new List<String>();
    List<String> dupfieldsToQuery = new List<String>();
    for (FieldSetField f : fieldSet) {
      if (f.type != 'PickList') {
        dupfieldsToQuery.add(f.fieldAPIName);
      } else {
        dupfieldsToQuery.add('toLabel(' + f.fieldAPIName + ')');
      }
      fieldsToQuery.add(f.name);
    }
    Lib_AuraEnabledAccessController.assertAuthorizedToView(
      Schema.getGlobalDescribe().get(Lib_NS.namespaceFix(sObjectName)),
      fieldsToQuery
    );
    String recordSOQL =
      'SELECT ' +
      String.escapeSingleQuotes(String.join(dupfieldsToQuery, ',')) +
      ' FROM ' +
      String.escapeSingleQuotes(Lib_NS.namespaceFix(sObjectName)) +
      ' WHERE Id = :recordId';
    for (SObject record : Database.query(recordSOQL)) {
      return record;
    }
    return null;
  }*/

  public class FieldSetField {
    @AuraEnabled
    public String name { get; set; }
    @AuraEnabled
    public String fieldAPIName { get; set; }
    @AuraEnabled
    public String label { get; set; }
    @AuraEnabled
    public String type { get; set; }

    public FieldSetField(Schema.FieldSetMember field) {
      this.name = field.fieldpath;
      this.fieldAPIName = field.fieldpath;
      this.label = field.label;
      this.type = String.valueOf(field.getType());
    }

    public FieldSetField(
      Schema.FieldSetMember field,
      Schema.SObjectField fieldDetails
    ) {
      this.name = field.fieldpath;
      this.fieldAPIName = field.fieldpath;
      this.label = field.label;
      this.type = String.valueOf(field.getType());

      Schema.DescribeFieldResult dfr = fieldDetails.getDescribe();
      if ('REFERENCE'.equalsIgnoreCase(this.type)) {
        System.debug(dfr.getReferenceTargetField());
        System.debug(dfr.getReferenceTo());
        System.debug(dfr.getRelationshipName());
        this.fieldAPIName = dfr.getRelationshipName() + '.Name';
      }
    }
  }

  /**
   * @description Get filter key, string type values.
   * @param  filters Filters map.
   * @param  key     Filter map key.
   * @param  values  Set to add values.
   */
  @namespaceAccessible
  public static void getValues(
    Map<String, Object> filters,
    String key,
    Set<String> values
  ) {
    for (Object strObj : (List<Object>) filters.get(key)) {
      values.add(String.valueOf(strObj));
    }
  }

  /**
   * @description Get filter key, string type values.
   * @param  filters Filters map.
   * @param  key     Filter map key.
   * @param  innerMapKey Inner map key.
   * @param  values  Set to add values.
   */
  @namespaceAccessible
  public static void getInnerValues(
    Map<String, Object> filters,
    String key,
    String innerMapKey,
    Set<String> values
  ) {
    for (Object mapVal : (List<Object>) filters.get(key)) {
      Map<Object, Object> innerMapVal = (Map<Object, Object>) mapVal;
      values.add(
        innerMapVal.containsKey(innerMapKey)
          ? String.valueOf(innerMapVal.get(innerMapKey))
          : ''
      );
    }
  }

  /**
   * @description Get filter key, string type values.
   * @param  filters Filters map.
   * @param  key     Filter map key.
   * @param  values  List to add values.
   */
  @namespaceAccessible
  public static void getValues(
    Map<String, Object> filters,
    String key,
    List<String> values
  ) {
    for (Object strObj : (List<Object>) filters.get(key)) {
      values.add(String.valueOf(strObj));
    }
  }

  /**
   * @description Get filter key, integer type values.
   * @param  filters Filters map.
   * @param  key     Filter map key.
   * @param  values  List to add values.
   */
  @namespaceAccessible
  public static void getValues(
    Map<String, Object> filters,
    String key,
    List<Integer> values
  ) {
    for (Object intObj : (List<Object>) filters.get(key)) {
      values.add(Integer.valueOf(intObj));
    }
  }

  /**
   * @description Get filter key, double type values.
   * @param  filters Filters map.
   * @param  key     Filter map key.
   * @param  values  List to add values.
   */
  @namespaceAccessible
  public static void getValues(
    Map<String, Object> filters,
    String key,
    List<Double> values
  ) {
    for (Object intObj : (List<Object>) filters.get(key)) {
      values.add(Double.valueOf(intObj));
    }
  }

  /**
   * @description Check if the value exists or not for the provided key in the filters.
   * @param  filters Filters map.
   * @param  key     Key name to check value.
   * @return         Key value exists or not.
   */
  /*@namespaceAccessible
  public static Boolean hasFilter(Map<String, Object> filters, String key) {
    return filters.containsKey(key) &&
      String.isNotBlank(String.valueOf(filters.get(key)));
  }

  *
   * @description Check if the value exists for the key and it's of list type.
   * @param  filters Filters map.
   * @param  key     Key name to check value.
   * @return         Key value exists or not and if yes then is a list or not.
   */
 /* @namespaceAccessible
  public static Boolean hasListFilter(Map<String, Object> filters, String key) {
    return filters.containsKey(key) &&
      !((List<Object>) filters.get(key)).isEmpty();
  }*/

  /*@AuraEnabled
  public static Map<String, Object> getRelatedRecords(
    String recordId,
    String sObjectName,
    String objectsRelations
  ) {
    Map<String, Object> r = new Map<String, Object>();

    r.put('recordId', recordId);
    r.put('sObjectName', sObjectName);
    r.put('objectsRelations', objectsRelations);

    Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
    Map<String, String> objectLabels = new Map<String, String>();
    Map<String, List<String>> objectRecords = new Map<String, List<String>>();
    for (String relation : objectsRelations.split(',')) {
      try {
        String query = 'SELECT Id FROM ';
        List<String> objectNamdRelationField = relation.trim().split(':');
        String tmpSObjectName = objectNamdRelationField[0];
        String sObjectRelationFieldName = objectNamdRelationField[1];

        Lib_AuraEnabledAccessController.assertAuthorizedToView(
          Schema.getGlobalDescribe().get(Lib_NS.namespaceFix(tmpSObjectName))
        );
        query += String.escapeSingleQuotes(tmpSObjectName);
        query +=
          ' WHERE ' +
          sObjectRelationFieldName +
          ' = :recordId ORDER BY Id DESC LIMIT 2000';
        query = String.escapeSingleQuotes(query);
        List<String> recordIds = new List<String>();
        for (sObject sObj : Database.query(query)) {
          recordIds.add('\'' + String.valueOf(sObj.get('Id')) + '\'');
        }

        String historyObj = (tmpSObjectName.removeEnd('__c') + '__History');
        // objectLabels.put(historyObj, gd.get((Lib_NS.namespaceFix(tmpSObjectName).toLowerCase().removeEnd('__c') + '__History')).getDescribe().getLabel());
        // Commented for NDMERP-1091
        if (tmpSObjectName == 'Expense_Claim__c') {
          objectLabels.put(historyObj, Label.Summary);
        } else {
          objectLabels.put(
            historyObj,
            Label.History_1 +
            ': ' +
            gd.get(Lib_NS.namespaceFix(tmpSObjectName).toLowerCase())
              .getDescribe()
              .getLabel()
          );
        }
        objectRecords.put(historyObj, recordIds);
      } catch (Exception ex) {
      }
    }
    r.put('objectLabels', objectLabels);
    r.put('parentIds', objectRecords);

    return r;
  }*/

 /* @AuraEnabled
  public static Map<String, Object> lib_getInstalledModulesConfig() {
    Map<String, Object> r = new Map<String, Object>();
    r.put('loggedInUserProfileInfo', Lib_Config.getLoggedInUserProfileInfo());
    r.put('availableModulesConfig', Lib_Config.getInstalledModules());
    return r;
  }

  @namespaceAccessible
  public static Map<String, Object> getInstalledModulesConfigBase() {
    return lib_getInstalledModulesConfig();
  }

  @namespaceAccessible
  public static Map<String, Boolean> getAvailableModules() {
    return Lib_Config.getInstalledModules();
  }*/

  @namespaceAccessible
  public static Boolean isMoreThan1CurrencyActive() {
    return false;
    /*
    List<CurrencyType> currencyList = [
      SELECT Id
      FROM CurrencyType
      WHERE IsActive = TRUE
      LIMIT 2
    ];
    return currencyList.size() > 1;
    */
  } 

  @namespaceAccessible
  public static void getCurrencyList(
    Map<String, Object> r,
    String selectedCurrencyIso
  ) {
    List<CurrencyWrapper> currencyList = new List<CurrencyWrapper>();
    // for (CurrencyType curren : [
    //   SELECT toLabel(IsoCode) IsoLabel, IsoCode
    //   FROM CurrencyType
    //   WHERE isActive = TRUE
    //   ORDER BY IsCorporate DESC
    // ]) {
    //   CurrencyWrapper curr = new CurrencyWrapper();
    //   curr.Id = curren.Id;
    //   curr.toLabel = String.valueOf(curren.get('IsoLabel'));
    //   curr.IsoCode = curren.IsoCode;
    //   if (selectedCurrencyIso != null && selectedCurrencyIso == curr.IsoCode) {
    //     r.put('selectedCurrency', curr.toLabel);
    //   }
    //   currencyList.add(curr);
    // }
    r.put('currencies', currencyList);
  }

  public class CurrencyWrapper {
    @AuraEnabled
    public string Id { get; set; }
    @AuraEnabled
    public String toLabel { get; set; }
    @AuraEnabled
    public String IsoCode { get; set; }
  }
}