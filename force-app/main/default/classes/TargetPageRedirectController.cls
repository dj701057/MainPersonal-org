public class TargetPageRedirectController {
 public PageReference GotoPreviousPage()
{
    PageReference pgRef =new PageReference('/apex/sourcePage');
    return pgRef.SetRedirect(true);
   }

}