public class RotateElement {
     public static void main() {    
            
        integer [] arr = new integer [] {1, 2, 3, 4, 5,6};     
            
        integer n = 5;    
           
            
        System.debug('Original array: ');    
        for (integer i = 0; i < arr.size(); i++) {     
            System.debug(arr[i] + ' ');     
        }      
            
        //Rotate the given array by n times toward right    
        for(integer i = 0; i < n; i++){    
            integer j, last;    
            //Stores the last element of array    
            last = arr[arr.size()-1];    
            
            for(j = arr.size()-1; j > 0; j--){    
                //Shift element of array by one    
                arr[j] = arr[j-1];    
            }    
            //Last element of array will be added to the start of array.    
            arr[0] = last;    
        }    
        
          
            
        //Displays resulting array after rotation    
        System.debug('Array after right rotation:');    
        for(integer i = 0; i< arr.size(); i++){    
            System.debug(arr[i] + ' ');    
        }    
    }    
}