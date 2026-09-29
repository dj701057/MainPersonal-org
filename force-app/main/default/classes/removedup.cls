public class removedup {
      public static void getTemplate() {       
        String str = '1.5.663,1.5.458,1.5.663,1.4.985';
        
         List<String> duplicateRemoveList = new List<String>(new Set<String>(str.split(',')));
         String uniquestr = String.join(duplicateRemoveList, ',');
          List<String> duplicateRemoveList1 = new List<String>(new Set<String>(str.split(',')));
         System.debug('uniquestr'+uniquestr);
    }
}