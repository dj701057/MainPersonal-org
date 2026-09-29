trigger AccountHaveOnlyThreeContact on Contact (before insert,before update) {
    ContactCreated.onlyTwoContactCreated(Trigger.new);

}