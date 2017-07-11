trigger ContactTrigger on Contact (before update, after update) {

	if(trigger.isBefore) {
		for(Contact c: trigger.new) {
			if(c.Title == 'CFO') {
				c.Langauges__c = 'German';
				c.Birthdate = System.today().addMonths(Integer.valueOf(c.Folio__c));
			}
		}
	}
}