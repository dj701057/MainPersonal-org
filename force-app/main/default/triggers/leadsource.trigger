//3. Whenever lead is created with lead source as web then give rating as cold otherwise hot
trigger leadsource on Lead (before insert) {
    for(lead l:trigger.New){
        if(l.leadsource =='Web'){
            l.Rating='Hot';
        }
        else{
            l.Rating ='Cold';
        }
       // system.debug('this is Lead test  :',leadsource);
    }

}