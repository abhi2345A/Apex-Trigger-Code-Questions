//Enforce Single Primary Contact on Account

Trigger restrictToOnePrimaryContact on Contact(before insert, before update){
    
    Set<Id>accIdSet = new Set<Id>();
    Set<Id>accIdWithPrimConSet = new Set<Id>();
    for(Contact con : Trigger.New){
        
        if( (Trigger.isInsert || (Trigger.isUpdate && ( (con.AccountId!=Trigger.oldMap.get(con.Id).AccountId) || (con.Primary_Contact__c!=Trigger.oldMap.get(con.Id).Primary_Contact__c)) )) && con.AccountId!=null){
            accIdSet.add(con.AccountId);
        }
    }
    
    if(!accIdSet.isEmpty()){
        
        for(Contact con : [Select AccountId from Contact where AccountId In: accIdSet and Primary_Contact__c=true]){
            accIdWithPrimConSet.add(con.AccountId);
        }
        
    }
    
    for(Contact con : Trigger.New){
        
        if(con.AccountId!=null && accIdWithPrimConSet.contains(con.AccountId)){
            con.addError('An Account can have maximum one primary Contact');
        }
    }
    
}

//Acc1 - con1, con2p
//Acc2 - con3, con4p