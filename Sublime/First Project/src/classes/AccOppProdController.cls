public class AccOppProdController {
	public Set<Id> ids {get;set}; //initializes or activates the variable
	public List<Account> accounts {get;set};
	public Map<Id, List<Contact>> contacts {get;set};


	public AccOppProdController() {
		
		accounts = new List<Account>();
		contacts = new Map<Id,List<Contact>>();
		ids = new Set<Id>();
	}

	Id idForAccount = ApexPages.currentPage().getParameters().get('id');
	accountList = [SELECT Name, Email, Website, Phone WHERE Id =: idForAccount ];

	for(account : accountList) {
		accounts.add(account.Id);
		contacts.put(account.Id , new List<Contact>();)



	}
}



			idsCuentas.add(cuenta.Id);
			nombreCuentas.add(cuenta.Name);
			mapaCuentas.put(cuenta.Id, cuenta);
			mapaCuentaContactos.put(cuenta.Id, new List<Contact>());
			mapaCuentaOppsProductos.put(cuenta.Id, new Map<Id, List<OpportunityLineItem>>()); //reserving space by putting the map with opportunity list on display regardless of populated or not
