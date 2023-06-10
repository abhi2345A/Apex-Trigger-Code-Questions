Trigger updateDeadIntel on Contact(after insert,after update){
    Set<Id>accountIdSet = new Set<Id>();
    Integer totalCount;
    Integer deadCount;
    for(Contact con : Trigger.New){
        if((Trigger.isInsert || (Trigger.isUpdate && con.Dead__c!=Trigger.oldMap.get(con.Id).Dead__c)) && String.isNotBlank(con.AccountId)){
            accountIdSet.add(con.AccountId);
        }
    }
    
    if(!accountIdSet.isEmpty()){
        
        for(Account ac : [select need_intel__c,(Select Dead__c from Contacts) from Account where Id In:accountIdSet]){
            totalCount = ac.contacts.size();
            deadCount = 0;
            for(Contact con : ac.contacts){
                if(con.Dead__c==true){
                    deadCount++;
                }
            }
            
            if(((deadCount*100)/totalCount)>70){
                acc.need_intel__c = true;
                accList.add(acc);
            }
        }
    }
    
    if(!accList.isEmpty()){
        update accList;
    }
}