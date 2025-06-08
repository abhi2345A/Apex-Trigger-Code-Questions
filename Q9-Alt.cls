Prevent duplication of contact records based on email //and phone


Trigger preventDuplicateTrigger on Contact(before insert, before update){
    
    Set<String> conEmails = new Set<String>();
    Set<String> conPhones = new Set<String>();
    Map<String, Boolean> emailToConExistMap = new Map<String, Boolean>();
    Map<String, Boolean> phoneToConExistMap = new Map<String, Boolean>();
    for(Contact con : Trigger.New){
        
        if(String.isNotBlank(con.email) && (Trigger.isInsert || (Trigger.isUpdate && con.email!=Trigger.oldMap.get(con.Id).email))){
            conEmails.add(con.email);
        }
        
        if(String.isNotBlank(con.phone) && (Trigger.isInsert || (Trigger.isUpdate && con.phone!=Trigger.oldMap.get(con.Id).phone))){
            conPhones.add(con.phone);
        }
    }
    
    for(Contact con : [Select email,phone from Contact where email In:conEmails or phone In:conPhones]){
        
        if(conEmails.contains(con.email) && !emailToConExistMap.containsKey(con.email))
            emailToConExistMap.put(con.email, true);
            
        if(conPhones.contains(con.phone) && !phoneToConExistMap.containsKey(con.phone))
            phoneToConExistMap.put(con.phone, true);
    }
    
    for(Contact con : Trigger.New){
        
        if(emailToConExistMap.get(con.email)==true || phoneToConExistMap.get(con.phone)==true){
            con.addError('Duplicate Found');
        }
    }
}