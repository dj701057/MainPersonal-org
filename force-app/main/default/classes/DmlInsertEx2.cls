public class DmlInsertEx2 {
    public static void test(){
        List<Contact>conList=[select firstname,lastname from contact];
        for(Contact cc:conList)
        {
            Contact c1=new Contact(lastname=cc.lastname,firstname=cc.firstname);
            insert c1;
        }
    }

}
// to many DML stmt ,Hence limit Reached