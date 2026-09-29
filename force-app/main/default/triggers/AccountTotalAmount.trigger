trigger AccountTotalAmount on Account (before insert) {
    if (Trigger.isBefore && Trigger.isUpdate) {
        AccountTotalAmountHandler.accountAmount(Trigger.newMap);
    }
}