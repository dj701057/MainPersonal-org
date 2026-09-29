public class DuplicateRemover {
    public static void main() {
    String demoString = 'a;b;a;v;c';
    String finalstr='';
    Integer i=0;
    for(i=0;i<demoString.length();i++){
      if(!finalstr.contains(demoString.substring(i,i+1)))
    	finalstr+=demoString.substring(i,i+1);
}
finalstr.trim();
System.debug('str:'+finalstr);
}
 
   
}