public class StudentMapExplorer {
    public static void StudentBasicMapMethod(){
        //all Student records and store them in a Map<Id, Student__c>
        Map<Id,Student__c> studentMap = new Map<Id,Student__c>([Select Id, Name, Gender__c,Description__c From Student__c]);
        System.debug('Student Map: ' + studentMap);
        
        //Map of Names and Students
        List<Student__c> studentList = [Select Id, Name, Gender__c,Description__c From Student__c] ;
        Map<String, Student__c> studentMapByName = new Map<String, Student__c>();
        for(Student__c Student : studentList) {
            studentMapByName.put(Student.Name,Student);
        }
        System.debug('Student Map By Name: ' + studentMapByName);
        
        //Check for a Specific Student in a Map
        if(studentMapByName.ContainsKey('Amit')){
            System.debug('Students with the name found: ' + studentMapByName.get('Amit'));
        }
        else {
            System.debug('No student with this name.');
        }
        
        //entrySet() to get both the key and value together in one iteration.
        Map<String, Student__c> studentMapForIteration = new Map<String, Student__c>{'Naveen' => new Student__c(Name='Naveen', Gender__c='Male'),
            'Deepak' => new Student__c(Name='Deepak', Gender__c='Male')};
                for(String key : studentMapForIteration.keySet()){
                    system.debug('Key: ' + key + ', Value: ' + studentMapForIteration.get(key));
                }           
        
        // Using .size() to Get the Total Count
        system.debug('studentMapFoSize ' + studentMapForIteration.size());
        
    }
    //Filter Students by Gender
    public static void filterStudentsByGender() {
        List<Student__c> studentList = [SELECT Id, Name, Gender__c, Description__c FROM Student__c];
        Map<String, List<Student__c>> genderStudentMap = new Map<String, List<Student__c>>();
        for (Student__c student : studentList) {
            String genderKey = student.Gender__c;
            if (!genderStudentMap.containsKey(genderKey)) {
                genderStudentMap.put(genderKey, new List<Student__c>());
            }
            genderStudentMap.get(genderKey).add(student);
        }
        System.debug('Gender Student Map: ' + genderStudentMap);
    }
    
    //Combine two maps without overwriting keys.
    public static void mergeTwoMaps() {
        Map<String, List<Student__c>> map1 = new Map<String, List<Student__c>>();
        map1.put('Male', new List<Student__c>{ new Student__c(Name='John', Gender__c='Male'), new Student__c(Name='Mike', Gender__c='Male') });
        map1.put('Female', new List<Student__c>{ new Student__c(Name='Jane', Gender__c='Female') });
        
        Map<String, List<Student__c>> map2 = new Map<String, List<Student__c>>();
        map2.put('Male', new List<Student__c>{ new Student__c(Name='Tom', Gender__c='Male'), new Student__c(Name='Mike', Gender__c='Male') });
        map2.put('Female', new List<Student__c>{ new Student__c(Name='Alex', Gender__c='Female') });
        
        for(String Key : map2.keyset()) {
            if(!map1.containskey(Key)){
                map1.put(key, map2.get(key));
            } else {
                map1.get(key).addAll(map2.get(key));
            }
        }
         System.debug('Merged Map: ' + map1);
    }
    public static void RemoveSpecifiEntry() {
        Map<Id,Student__c> studentMap = new Map<Id,Student__c>([Select Id, Name, Gender__c,Description__c From Student__c]);
        Id KeyToremove = 'a0FJ4000000VGtjMAG' ;
        if(studentMap.containskey(KeyToremove)){
            studentMap.remove(KeyToremove);
            system.debug('studentMap'+studentMap);
        }
    }
    public static void processMapWithNulls() {
        Map<String, String> testMap = new Map<String, String>();
        testMap.put('Key1', 'Value1');
        testMap.put('Key2', null);
        testMap.put(null, 'Value3');
        testMap.put('Key4', 'Value4');
        
        for(String Key : testMap.KeySet()) {
            if(key == null){
                System.debug('Null key found, skipping this entry.');
                continue;
            }
            
             String value = testMap.get(key);
            if(value == null){
                System.debug('Null value found for key: ' + key + ', setting default value.');
                value = 'Default Value';
            }
            
             // Process non-null key-value pair
            System.debug('Processing key: ' + key + ', value: ' + value);
        }         
    }
}