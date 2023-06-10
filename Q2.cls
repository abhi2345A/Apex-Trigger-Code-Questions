trigger createAccountTrigger on Contact(before insert){
    
    List<Account>accList = new List<Account>();
    Map<String,Contact> accNameToContactMap = new Map<String,Contact>();
    
    for(Contact con : Trigger.New){
        
        if(String.isBlank(con.AccountId)){
            
            String name = con.firstname+' '+con.lastname;
            Account ac = new Account();
            ac.Name = name;
            ac.email = con.email;
            accList.add(ac);
            accNameToContactMap.put(name,con);
        }
    }
    
    if(!accList.isEmpty){
        insert accList;
        
        for(Account ac : accList){
            if(accNameToContactMap.containskey(ac.name)){
                accNameToContactMap.get(ac.name).accountId = ac.Id;
            }
        }
    }
}