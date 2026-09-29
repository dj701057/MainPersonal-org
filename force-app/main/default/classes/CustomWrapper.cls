public class CustomWrapper {
    public Id recordID{get;set;}
    public string firstName{get;set;}
    public string lastName{get;set;}
    public string IndustryName{get;set;}
    public string ratingValue{get;set;}
    public string designation{get;set;}
    public decimal AnnualRevenueValue{get;set;}
    public string PhoneNumber{get;set;}
    public string faxNumber{get;set;}
    public string CountryName{get;set;}
    public boolean isSelected{get;set;}
    
    //prepare a constructor to convert the account into Custom Type.
    public CustomWrapper(Account acc , Boolean Selection)
    {
        recordID=acc.id;
        lastName=acc.name;
        ratingValue=acc.Rating;
        AnnualRevenueValue=acc.AnnualRevenue;
        PhoneNumber=acc.Phone;
        faxNumber=acc.Fax;
        IndustryName=acc.Industry;
        isSelected=Selection;
    }
    //prepare a constructor to convert the lead record into Custom type.
    public CustomWrapper(Lead ld ,Boolean Selection)
    {
        recordID=ld.id;
        firstName=ld.FirstName;
        lastName=ld.lastname;
        ratingValue=ld.Rating;
        PhoneNumber=ld.Phone;
        faxNumber=ld.Fax;
        IndustryName=ld.Industry;
        designation=ld.Title;
       isSelected=Selection;
    }
    //prepare a constrictor to convert contact record into custom type.
    public CustomWrapper(Contact con ,Boolean Selection)
    {
        recordID=con.id;
        firstName=con.FirstName;
        lastName=con.lastname;
        PhoneNumber=con.Phone;
        faxNumber=con.Fax;
        designation=con.Title;
        isSelected=Selection;
    }
}