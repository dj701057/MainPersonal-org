trigger Assign4_9 on Opportunity (before insert) {
    Id loggedInUserId = UserInfo.getUserId();
    List<Opportunity> opp = [Select Id, StageName From Opportunity Where CreatedById =: loggedInUserId 
                              and StageName = 'Prospecting'];
    if(opp != null && opp.size() > 2 ) {
       // opp.addError('You can"t add more than two open opportunity');
    }

}