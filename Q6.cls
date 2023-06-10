Trigger updateAccount on Opportunity(after insert,after update){
    
    Set<Id>accIdSet = new Set<Id>();
    List<Account>accList = new List<Account>();
    for(Opportunity opp : Trigger.New){
        
        if((Trigger.isInsert || (Trigger.isUpdate && opp.Amount!=Trigger.oldMap.get(opp.Id).Amount)) && opp.Amount>20000 && String.isNotBlank(opp.AccountId)){
            accIdSet.add(opp.AccountId);
        }
    }
    
    if(!accIdSet.isEmpty()){
        for(Account ac : [select is_gold from Account where Id In: accIdSet]){
            ac.is_gold = true;
            accList.add(ac);
        }
    }
    
    if(!accList.isEmpty()){
        update accList;
    }
}