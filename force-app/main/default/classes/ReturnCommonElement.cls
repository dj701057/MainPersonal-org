public class ReturnCommonElement {
    public static void main(){
       List<Integer> a = new List<Integer>{1,4,7,8};
       List<Integer> b = new List<Integer>{2,5,3,6,4,8,9};
       List<Integer> c = new List<Integer>{9,5,2,7,4};


for(integer i=0;i<a.size();i++){
    if(b.contains(a[i]) && c.contains(a[i])) {
        system.debug(a[i]);
    }
 }


}
    

}