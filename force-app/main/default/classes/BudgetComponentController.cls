public class BudgetComponentController {
	@AuraEnabled(cacheable=true)
    public static List<User> getUsers() {
        return [SELECT Id, Name FROM User];
    }
}