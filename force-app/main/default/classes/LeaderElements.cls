public class LeaderElements {
    public static  void main(){
        integer []arr= new integer[]{149,1,3,248,2,8,70,5};
            for(integer i=0;i<arr.size();i++){
                boolean flag=false;
                integer j;
                for( j=i;j<arr.size();j++){
                    if(arr[i]<arr[j]){
                        flag=true;
                        break;
                    }
                }
                if(flag==false){
                    system.debug('flag value='+arr[i]);
                }
            }
        
    }

}