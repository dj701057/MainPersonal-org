public with sharing class Acc_TemplateEditorCtrl {
  public String objectsFields { get; set; }
  public String vfHostURL { get; set; }
  public String templateContent { get; set; }
  public String language { get; set; }

  public Acc_TemplateEditorCtrl() {
    String objects = ApexPages.currentPage().getParameters().get('objects');
    String recordId = ApexPages.currentPage().getParameters().get('recordId');
    vfHostURL = ApexPages.currentPage().getParameters().get('vfHostURL');
    objectsFields = JSON.serialize(new List<Map<String, Object>>());
    
  }
}