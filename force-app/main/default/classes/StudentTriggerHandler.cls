public class StudentTriggerHandler {
    public static void preventDuplicateEmail(List<Student__c>newStudents){
        List<String> emailList = new List<String>();
        for(student__c stud : newStudents){
            if(stud.Email__c != null){
                emailList.add(stud.Email__c);
            }
        }
        
        if(emailList.size() > 0){
            List<Student__c> existingStudents = [select id , Name , Email__c from Student__c where Email__c =: emailList];
            for(Student__c stud : newStudents){
                if(existingStudents.size() > 0){
                    stud.addError('Email already exists');
                }
            }
        }
    }
    
    public static void preventDuplicateEmailByMap(List<Student__c> newStudents) {
        system.debug('inside preventDuplicateEmailByMap');
        
        Set<String> emailSet = new Set<String>();
        for (Student__c stud : newStudents) {
            if (stud.Email__c != null) {
                emailSet.add(stud.Email__c);
            }
        }
        system.debug('Collected Emails from newStudents: ' + emailSet);
        
        Map<String, Student__c> existingEmailByStudentMap = new Map<String, Student__c>();
        if (!emailSet.isEmpty()) {
            List<Student__c> existingStudents = [SELECT Id, Name, Email__c FROM Student__c WHERE Email__c IN :emailSet ];
            system.debug('Queried Existing Students: ' + existingStudents);
            
            for (Student__c student : existingStudents) {
                existingEmailByStudentMap.put(student.Email__c, student);
            }
            system.debug('Populated existingEmailByStudentMap: ' + existingEmailByStudentMap);
        }
        
        for (Student__c stud : newStudents) {
            if (stud.Email__c != null && existingEmailByStudentMap.containsKey(stud.Email__c)) {
                stud.addError('Email already exists for student: ' + existingEmailByStudentMap.get(stud.Email__c).Name);
                system.debug('Duplicate Email Found: ' + stud.Email__c + ' already belongs to: ' + existingEmailByStudentMap.get(stud.Email__c).Name);
            }
        }
    }
    
    //updateDescriptionBasedOnGender 
    public static void updateDescriptionBasedOnGender (List<Student__c> newStudents){
        Map<String,String> GenderDescriptionMap = new Map<String,String>();
        genderDescriptionMap.put('Male', 'New Delhi');
        genderDescriptionMap.put('Female', 'UP');
        system.debug('Gender Description Map: ' + genderDescriptionMap);
        
        for(Student__c stud : newStudents){
            if(stud.Gender__c != null && GenderDescriptionMap.containsKey(stud.Gender__c)){
                stud.Description__c = genderDescriptionMap.get(stud.Gender__c);
                system.debug('Updated Description for Student: ' + stud.Name + 
                             ', Gender: ' + stud.Gender__c + ', Description: ' + stud.Description__c);
            }
        }
    }
}