//Whenever opportunity stagename is modified to closed won then set closedate as today and type as customer
trigger stageNameOpp on Opportunity (before insert) {
   for(Opportunity opp:trigger.new){
   if(opp.Stagename == 'Closed Won')
    {      
           opp.CloseDate= System.today();
           opp.Type ='Customer';
    }
  }  

}