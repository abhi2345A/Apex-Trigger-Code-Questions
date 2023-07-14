//Write a trigger on contact to prevent duplicate records based on Contact Email & Contact Phone.


Trigger restrictDuplicateContacts on Contact(before insert,before update){
    
    Map<String,Contact> emailToContactMap = new Map<String,Contact>();
    Map<String,Contact> phoneToContactMap = new Map<String,Contact>();
    
    for(Contact con : Trigger.New){
        
        if(Trigger.isInsert || (Trigger.isUpdate && con.email!=Trigger.oldmap.get(con.Id).email) && con.email!=null){
            emailToContactMap.put(con.email,con);
        }
        
        if(Trigger.isInsert || (Trigger.isUpdate && con.phone!=Trigger.oldmap.get(con.Id).phone) && con.phone!=null){
            phoneToContactMap.put(con.phone,con);
        }
    }
    
    for(Contact con : [Select email,phone from Contact where email In :emailToContactMap.keySet() OR phone In :phoneToContactMap.keySet()]){
        
        if(emailToContactMap.containsKey(con.email)){
            emailToContactMap.get(con.email).addError('Duplicate Contact');
        }else if(phoneToContactMap.containsKey(con.Phone)){
            phoneToContactMap.get(con.Phone).addError('Duplicate Phone');
        }
    }
}