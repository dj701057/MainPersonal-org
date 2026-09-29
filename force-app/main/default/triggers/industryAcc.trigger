//When a new Account record is inserted verify the industry field value, if industry field value is Education then assign the owner as Deepak
trigger industryAcc on Account (before insert) {
    User u=[select id from User where username='deepak.astrea.it70@empathetic-otter-9c1rzm.com'];
 
     for(Account acc:trigger.new)  
   {     
 
    if(acc.Industry =='Education')      
   {          
      acc.ownerId = u.id;    
  
   } 
 
 }

}