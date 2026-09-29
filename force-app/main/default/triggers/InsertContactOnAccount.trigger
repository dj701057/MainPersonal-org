trigger InsertContactOnAccount on Account (after insert) {

List<Contact> con = new List<Contact>();
List<id> ide = new List<id>();
for(Account acc:Trigger.new)
ide.add(acc.id);
integer i,j;
for(i=0,j=0;j<3&&i<ide.size();j++){
contact c = new contact(lastName = 'test'+j, accountId= Trigger.new.get(i).id);
con.add(c);
if(j==2){
i++;
j=0;
}
}

insert con;
}