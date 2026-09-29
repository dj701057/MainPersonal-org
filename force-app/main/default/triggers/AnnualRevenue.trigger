trigger AnnualRevenue on Account (After insert) {
   List<Contact> cc  = new list<Contact>();
      for(Account acc:trigger.new)
    {
            if(acc.AnnualRevenue>50000)
              { 
              Contact con = new Contact();
                 con.FirstName ='Deepak';
                 con.lastName ='Jaiswal';
                 con.accountid=acc.id;
                 cc.add(con);
                  system.debug('Contact value are'+con);
              }  
    }      
              insert cc;                
         }