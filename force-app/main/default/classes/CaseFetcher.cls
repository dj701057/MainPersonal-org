public class CaseFetcher {
    /*public static List<Case> fetchCasesByStatus(String status) {
        String query = 'SELECT Id, Subject, Status FROM Case WHERE Status = :status';
        Map<String, Object> params = new Map<String, Object>();
        params.put('status', status);
        system.debug('Database.query(query)'+Database.query(query).size());
        return Database.query(query);
        
    }*/
    public static List<Case> fetchCasesByStatus(String status) {
       // String query = 'SELECT Id, Subject, Status FROM Case WHERE Status = \'' + status + '\'';
        String query = 'SELECT Id, Subject, Status FROM Case WHERE Status = :status';
        system.debug('Database.query(query)'+Database.query(query).size());
        return Database.query(query);
    }
    
    public static Integer getLeadCount() {
					String query = 'SELECT COUNT() FROM Lead';
					return Database.countQuery(query);
				}
    
    public static void fetchAccounts(String nameStart) {
        List<Account> accounts = [SELECT Id, Name FROM Account WHERE Name LIKE :nameStart+'%'];
        for (Account acc : accounts) {
            System.debug('Account Name: ' + acc.Name);
        }
    }
    
    public static Map<String, List<Account>> getAccounts(String startWith) {
        Map<String, List<Account>> accountsMap = new Map<String, List<Account>>();
        List<Account> accounts = [SELECT Id, Name FROM Account WHERE Name LIKE :startWith + '%'];
        accountsMap.put(startWith, accounts);
        system.debug('accountsMap'+accountsMap);
        return accountsMap;
    }
    
}