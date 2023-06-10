trigger updatAccountCheckbox on Contact(after insert){
    Set<Id>accIdSet = new Set<Id>();
    List<Account>accsToBeUpdated = new List<Account>();
    for(Contact con : Trigger.New){
        if(String.isNotBlank(con.AccountId)){
            accIdSet.add(con.AccountId);
        }
    }
    
    if(!accIdSet.isEmpty()){
        for(Account ac : [select Contact_Created__c from Account where Id IN : accIdSet]){
            if(ac.Contact_Created__c!=null && !ac.Contact_Created__c){
                ac.Contact_Created__c = true;
                accsToBeUpdated.add(ac);
            }
        }
    }
    
    if(!accsToBeUpdated.Empty()){
        update accsToBeUpdated;
    }
}