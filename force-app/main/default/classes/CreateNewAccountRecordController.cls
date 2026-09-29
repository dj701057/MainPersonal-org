public class CreateNewAccountRecordController {
    public string recordResult{get;set;}
    public void CreateAccountRecord(){
    Account acc=new Account();
    acc.Name='Custom Controller';
    acc.rating='Hot';
    acc.Phone='91203545222';
    
    insert acc;
    if(acc.id !=null)
        recordResult ='Account record Inserted Successfully '+acc.id;
     else
         recordResult ='Something Went Wronge while inserting the record';
    }
}