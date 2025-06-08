// Trigger to count the number of OpportunityLineItems associated with an opportunity and display the count on Account's custom field.

Trigger countOpptyLineItems on OpportunityLineItem(after insert){
    
    Set<Id> opptyIds = new Set<Id>();
    Map<Id, Integer> AccountIdToCountMap = new Map<Id, Integer>();
    List<Account>accountsToBeUpdated = new List<Account>();
    for(OpportunityLineItem oppLineIt : Trigger.new){
        opptyIds.add(oppLineIt.OpportunityId);
    }
    
    for(AggregateResult asr : [Select count(Id) IdCount, Opportunity.AccountId accountId from OpportunityLineItem where OpportunityId In:opptyIds group by Opportunity.AccountId]){
        
        AccountIdToCountMap.put((Id)asr.get('accountId'),  (Integer)asr.get('IdCount'));
    }
    
    for(Id accId : AccountIdToCountMap.keySet()){
        
        accountsToBeUpdated.add(new Account(Id=accId,total_products__c=AccountIdToCountMap.get(accId)));
    }
    
    if(!accountsToBeUpdated.isEmpty())
        update accountsToBeUpdated;
    
}