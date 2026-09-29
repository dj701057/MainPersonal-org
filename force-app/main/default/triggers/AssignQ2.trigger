// Q2 When an opportunity is inserted check for it's duplicacy on the basis of its name and the account to 
// which it is related to i.e. If it has same name and it's linked to same Account then
//append "Duplicate Opportunity" in the name
trigger AssignQ2 on Opportunity (before insert) {
    Set<ID> setacc  = new Set<ID>();
    for (Opportunity oppty: Trigger.new){
        setacc.add(oppty.AccountID);
    }
    List<Account> AccList = [SELECT ID, Name,(SELECT Name FROM Opportunities)FROM Account WHERE ID IN :setacc];
    Map<ID,List<String>> AccOppMap = new Map<ID,List<String>>();
    for (Account Acc: AccList) {
        List<String> OpptName = new List<String>();
        for (Opportunity o: Acc.Opportunities){
            OpptName.add(o.Name);
        }
        AccOppMap.put(Acc.Id, OpptName);
    }
    for (Opportunity tr : Trigger.new){
        if (AccOppMap.get(tr.AccountId).contains(tr.Name)) {
            tr.Name = 'Duplicate Record ' + tr.Name;
        }
    }

}