trigger ApexTriAssign on Account (before insert,after insert,before update,after update,before delete,after delete) {
    if(Trigger.IsBefore){
        if(Trigger.isInsert){
            
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
           // Assign4_1.sol1(Trigger.New);
            
        }
        else if(Trigger.isDelete){
            
        }
        else if(Trigger.isUndelete){
            
        }
        
    }

}