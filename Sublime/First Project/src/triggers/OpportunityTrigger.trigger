trigger OpportunityTrigger on Opportunity (before update) {

	Set<Id> accountIds = new Set<Id>();

	for(Opportunity opp : trigger.new) {
		if(opp.StageName == 'Negotiation/Review' && trigger.oldMap.get(opp.Id).StageName != 'Negotiation/Review') {
			accountIds.add(opp.AccountId);
		}

		if(opp.StageName == 'Closed Lost' && trigger.oldMap.get(opp.Id).StageName != 'Closed Lost' && 
			opp.Reasons_For_Loss__c == null) {
			opp.Reasons_For_Loss__c.addError('Reason for opportunity loss is required');
		}
	}

	if(accountIds.size() > 0) {
		List<Account> accounts = [SELECT Date__c FROM Account WHERE Id IN: accountIds];

		for(Account acc : accounts) {
			acc.Date__c = System.today();
			update accounts;
		}

		List<SObject> recordsList = new List<SObject>();
		List<SObject> taskList = new List<SObject>();
		Schema.SobjectType accountSchema = Schema.getGlobalDescribe().get('Account');
		Schema.SobjectType taskSchema = Schema.getGlobalDescribe().get('Task');

		for (Id accountId : accountIds) {

			SObject sobj;

			sobj = accountSchema.newSObject(accountId);
			sobj.put('Date__c', System.today());
			recordsList.add(sobj);

			SObject sobj2;
			sobj2 = taskSchema.newSObject();
			sobj2.put('Subject', 'Asunto');
			sobj2.put('WhatId', accountId);
			sobj2.put('OwnerId', UserInfo.getUserId());
			sobj2.put('Status', 'Not Started');
			sobj2.put('Priority', 'High');

			recordsList.add(sobj2);

		}
		upsert recordsList;
		insert taskList;

	}
}






