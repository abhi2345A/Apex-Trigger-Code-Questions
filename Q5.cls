Trigger updateContact on Account(after update){
    
    Set<Id> accIdSet = new Set<Id>();
    List<Contact>conList = new List<Contact>();
    for(Account ac : Trigger.New){
        
        if(ac.website!=null && ac.website!=Trigger.oldMap.get(ac.Id).website){
            accIdSet.add(ac.Id);
        }
    }
    
    if(!accIdSet.isEmpty()){
        for(Contact con : [select Profile__c,Account.website from Contact where accountId IN : accIdSet]){
            if(con.firstname!=null){
                con.Profile__c = con.Account.website + '/' + con.firstname.substring(0,1) + con.lastname;
                conList.add(con);
            }
        }
    }
    
    if(!conList.isEmpty()){
        update conList;
    }
}