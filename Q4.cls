trigger updateAccount on Account(before update){
    
    Set<Id>accIdSet = new Set<Id>();
    Map<Id,Integer>AccountToContactsMap = new Map<Id,Integer>();
    for(Account ac : Trigger.New){
    
        Account oldAcc = Trigger.Oldmap.get(ac.Id);
        if(ac.billingStreet!=oldAcc.billingStreet || ac.billingCity!=oldAcc.billingCity || ac.billingState!=oldAcc.billingState |                                        ac.billingPostalCode!=oldAcc.billingPostalCode || ac.billingCountry!=oldAcc.billingCountry){
            
            accIdSet.add(ac.Id);
        }
    }
    
    if(!accIdSet.isEmpty){
        for(Contact con : [Select MailingPostalCode,AccountId from Contact where AccountId In:accIdSet]){

            if(con.MailingPostalCode!=Trigger.newMap.get(con.AccountId).billingPostalCode){

                if(AccountToContactsMap.containsKey(con.AccountId)){
                    AccountToContactsMap.put(accountId,AccountToContactsMap.get(con.accountId)+1);
                }else{
                    AccountToContactsMap.put(con.accountId,1);
                }
            }
        }
    }
    
    for(Account ac : Trigger.New){
        
        ac.Out_of_Zip = AccountToContactsMap.containsKey(ac.Id) && AccountToContactsMap.get(ac.Id)>1 ? true : false;
    }
}