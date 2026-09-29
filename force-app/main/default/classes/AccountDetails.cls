public class AccountDetails {
    private string accountName;
    private Integer accountNo;
    
    public string getName(){
        return this.accountName;
    }
    public void setName(String name){
        this.accountName = name;
    }
    public void setAccountNo(Integer accountNo){
         this.accountNo = accountNo;
    }
    public integer getAccountNo(){
        return this.accountNo;
    }
}