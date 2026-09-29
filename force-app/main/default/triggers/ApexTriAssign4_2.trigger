trigger ApexTriAssign4_2 on Opportunity (before insert,after insert,before update,after update,before delete,after delete) {
    if(Trigger.IsBefore){
        if(Trigger.isInsert){
            Assign4_9.sol(Trigger.new);
            
        }
        else if(Trigger.isUpdate){
            
            
        }
        else if(Trigger.isDelete){
            
        }
        else if(Trigger.isUndelete){
            
        }
    }
    else if(Trigger.isAfter)
    {
        if(Trigger.isInsert){
            
        }
        else if(Trigger.isUpdate){
            
            
        }
        else if(Trigger.isDelete){
            
        }
        else if(Trigger.isUndelete){
            
        }
        
    }

}