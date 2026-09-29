trigger InsertContact on Account (after insert)
{
    List <Contact> cntLst = new List<Contact>();
        for(Account acc: Trigger.New)
        {
            Contact cnt = new Contact();
            cnt.LastName = 'Deepak'+''+ acc.name;
             cnt.AccountId=acc.id;
            cntLst.Add(cnt);
         }
             insert cntLst;
}