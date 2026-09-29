public class JobSharing {
    public static boolean manualShareRead(Id recordId, Id userOrGroupId){
        Job__Share JobShr =new Job__Share();
        JobShr.ParentId =recordId;
        JobShr.UserOrGroupId = userOrGroupId ;
        JobShr.AccessLevel = 'Read';
        JobShr.RowCause =Schema.Job__Share.RowCause.Manual;
        Database.SaveResult sr = Database.insert(JobShr,false);
        if(sr.isSuccess()){
         // Indicates success
         return true;
         }
        else{
            Database.Error err = sr.getErrors()[0]; 
            if(err.getStatusCode() == StatusCode.FIELD_FILTER_VALIDATION_EXCEPTION  &&  
               err.getMessage().contains('AccessLevel')){
                   // Indicates success.
                   return true;
               }
            else {
                // Indicates failure.
                return false;
            }
        }
    }

}