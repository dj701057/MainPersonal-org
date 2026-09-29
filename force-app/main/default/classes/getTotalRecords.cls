public class getTotalRecords {
    public static integer getObjectName(string objName){
        string sQuery = 'Select Id from ' + objName;
        List<Sobject> lstObject = database.query(sQuery);
        return lstObject.size();
    }
}