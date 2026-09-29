trigger preventCaseDeletion on Case (before delete) {
    List <case> caseList =[select id ,(select id from Tasks) from case where id in:trigger.old];
    for(case c:trigger.old){
        for(case c1 :caseList){ 
            if(c1.Tasks.size()>=1){ 
                c.addError('Case cannot be deleted beacause it contains a important task so plz checked before delete....');
            
            }
        }
   }

}