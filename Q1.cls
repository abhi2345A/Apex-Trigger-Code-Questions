trigger createDefaultContact on Account(after insert){
    
    List<Contact> conList = new List<Contact>();
    List<Account> accList = new List<Account>();
    Set<Id> accountIdSet = new Set<Id>();
    for(Account ac : Trigger.New){
        
        Contact con = new Contact();
        con.firstname = 'Info';
        con.lastname = 'Default';
        con.email = 'info@websitedomain.tld';
        con.accountId = ac.Id;
        conList.add(con);
        accountIdSet.add(ac.Id);  
    }
    
    if(!conList.isEmpty){
        insert conList;
    }
    
    for(Account ac : [select Only_Default_Contact__c,(Select Id from contacts) from Account where Id IN :accountIdSet]){
        
        if(ac.contacts.size()>1){
            ac.Only_Default_Contact__c = false;
            accList.add(ac);
        }else if(ac.contacts.size()==1){
            ac.Only_Default_Contact__c = true;
            accList.add(ac);
        }
    }
    
    if(!accList.isEmpty()){
        update accList;
    }
    
}