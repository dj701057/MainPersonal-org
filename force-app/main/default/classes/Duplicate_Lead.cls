public class Duplicate_Lead {
    public static void afterInsert(List<Lead> leads) {
      
        List<Lead> leadIDs = new List<Lead>();

        for(Lead ld : leads){
            leadIDs.add(ld);
        }

       List<Lead> cloned = leadIDs.Clone();
       //INSERT cloned;
       System.debug('Cloned '+ cloned);
    }

}