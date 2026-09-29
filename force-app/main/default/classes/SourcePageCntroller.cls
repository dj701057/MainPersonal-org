public class SourcePageCntroller {
    public PageReference GotoTargetPage()
    {
        PageReference pgRef =new PageReference('/apex/TargetPage');
        return pgRef.SetRedirect(true);
        }
}