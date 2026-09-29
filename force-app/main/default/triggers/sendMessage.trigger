trigger sendMessage on Account (before insert) {
    sObject contact = [Select Name, Phone, Title, MobilePhone from Contact ];

    String data = '{"contactInfo":'+JSON.serialize(contact)+'}';    

    //sendMessageOnTrigger sendMessage = new sendMessageOnTrigger();
    sendMessageOnTrigger.sendMessage(data);


}