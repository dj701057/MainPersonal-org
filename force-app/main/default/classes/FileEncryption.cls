public class FileEncryption {

    public static void encryptFile(set<Id> recordId) {
        List<Attachment> attachments = [SELECT Id, Name, Body FROM Attachment WHERE ParentId = :recordId];
        if(! attachments.isEmpty()){
            System.debug('No attachment exists for the record');
        }else{
            Blob encryptionKey = Crypto.generateAesKey(256);
            for(Attachment a: attachments){
                a.Body = Crypto.encryptWithManagedIV('AES256', encryptionKey, a.Body);
                update a;
            }
        }
    }

    public static void decryptFile(Id attachmentId) {
        Attachment a = [SELECT Id, Body FROM Attachment WHERE Id = :attachmentId];
        if(a == null){
            System.debug('No attachment exists for the id');
        }else{
            Blob encryptionKey = Crypto.generateAesKey(256);
            a.Body = Crypto.decryptWithManagedIV('AES256', encryptionKey, a.Body);
            update a;
        }
    }
}