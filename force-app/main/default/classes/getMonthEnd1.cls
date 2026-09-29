public class getMonthEnd1{
           public static string getMonthEnd1(date thisdate ){
       String month;
            Integer dt =  thisdate.day();
            Integer dtMonth = thisdate.month();            
            if(dtMonth == 1){
              month = 'Jan'+' '+ string.ValueOf(dt);
            }
            if(dtMonth == 2){
              month = 'Feb'+' '+ string.ValueOf(dt);
            }
            if(dtMonth == 3){
              month = 'Mar'+' '+ string.ValueOf(dt);
            }
            if(dtMonth == 4){
              month = 'Apr'+' '+ string.ValueOf(dt);
            }
            if(dtMonth == 5){
              month = 'May'+' '+ string.ValueOf(dt);
            }
            if(dtMonth == 6){
              month = 'Jun'+' '+ string.ValueOf(dt);
            }
            if(dtMonth == 7){
              month = 'Jul'+' '+ string.ValueOf(dt);
            }
            if(dtMonth == 8){
              month = 'Aug'+' '+ string.ValueOf(dt);
            }
            if(dtMonth == 9){
              month = 'Sep'+' '+ string.ValueOf(dt);
            }
            if(dtMonth == 10){
              month = 'Oct'+' '+ string.ValueOf(dt);
            }            
            if(dtMonth == 11){
              month = 'Nov'+' '+ string.ValueOf(dt);
            }
            if(dtMonth == 12){
              month = 'Dec'+' '+ string.ValueOf(dt);
            }
        return month;
    }
}