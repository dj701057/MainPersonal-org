public class ShowAccountNameController {
    public List<SelectOption> lstOptions{get;set;}
    
    public ShowAccountNameController()
    {
      lstOptions = new List<SelectOption>();
      List<Account>lstAccount = [select id ,name from Account order by Name];
      //For None
      SelectOption option1 = new SelectOption('' ,'---None---');
      lstOptions.Add(option1);

      for(Account acc : lstAccount)
      {
          SelectOption option = new SelectOption(acc.id ,acc.name);
          lstOptions.Add(option);
      }
    }

}