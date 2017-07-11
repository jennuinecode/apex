public class ConjuntosDatos {
	public List<Account> cuentas {get;set;} //setting variable that will be a list of accounts
	public Set<Id> idsCuentas {get;set;} //setting variable that will be a set of account id's
	public Set<String> nombreCuentas {get;set;} //setting variable that will be a set that will be a string to cold the account name
	public Map<Id, Account> mapaCuentas {get;set;} // setting variable that will be a dictionary that will hold account id : account
	public Map<Id, Opportunity> mapaOportunidades {get;set;} // setting variable that will be a dictionary that will hold opportunity id: opportunity
	public Map<Id,List<Contact>> mapaCuentaContactos {get;set;} // setting variable that will be a dictionary that holds the contact id : contact that pertains to specific acccount
	public Map<Id, Map<Id, List<OpportunityLineItem>>> mapaCuentaOppsProductos{get;set;} //dictionary within a dictionnary that holds 



	public ConjuntosDatos() {

		cuentas = [SELECT Id, Name, Website, Type FROM Account LIMIT 10]; //filling list from line #2 with accounts

		idsCuentas = new Set<Id>(); //initializes or activates the variable
		nombreCuentas = new Set<String>(); 
		mapaCuentas = new Map<Id, Account>();
		mapaOportunidades = new Map<Id, Opportunity>();
		mapaCuentaContactos = new Map<Id, List<Contact>>();
		mapaCuentaOppsProductos = new Map<Id, Map<Id, List<OpportunityLineItem>>>();


		for(Account cuenta : cuentas) { //filing set from line #3 with a set with id :

			idsCuentas.add(cuenta.Id);
			nombreCuentas.add(cuenta.Name);
			mapaCuentas.put(cuenta.Id, cuenta);
			mapaCuentaContactos.put(cuenta.Id, new List<Contact>());
			mapaCuentaOppsProductos.put(cuenta.Id, new Map<Id, List<OpportunityLineItem>>()); //reserving space by putting the map with opportunity list on display regardless of populated or not
		}


		List<Contact> contactos = [SELECT AccountId, Name, Department FROM Contact WHERE AccountId IN : idsCuentas]; //generating contacts variable which holds list of contact that are related to account id
		for(Contact contacto : contactos){ //going to loop through contacts to b2egin filling in map 

			if(!mapaCuentaContactos.containsKey(contacto.AccountId)){

				mapaCuentaContactos.put(contacto.AccountId, new List<Contact>()); //creating list where list of contacts can be stored specifically for accountID if the current map does not have a contact list
			}

			mapaCuentaContactos.get(contacto.AccountId).add(contacto); //if list does exisist, the addition of the contact in current iteration is added
		}


		List<Opportunity> oportunidades = [SELECT Id, Name, Amount, AccountId FROM Opportunity WHERE AccountId IN : idsCuentas];
		mapaOportunidades = new Map<Id, Opportunity>();
		for(Opportunity oportunidad : oportunidades) {

			mapaCuentaOppsProductos.get(oportunidad.AccountId).put(oportunidad.Id, new List<OpportunityLineItem>()); 
			mapaOportunidades.put(oportunidad.Id, oportunidad);
		}


		for(OpportunityLineItem oppLineItem : [SELECT Product2.Name, Quantity, UnitPrice, TotalPrice, OpportunityId FROM OpportunityLineItem WHERE OpportunityId IN : oportunidades]) {
			
			Map<Id, List<OpportunityLineItem>> mapaCuentaOppsProductosTemp = mapaCuentaOppsProductos.get(oppLineItem.Opportunity.AccountId);
			List<OpportunityLineItem> productosTemp = mapaCuentaOppsProductosTemp.get(oppLineItem.OpportunityId);
			productosTemp.add(oppLineItem);
			mapaCuentaOppsProductos.get(oppLineItem.Opportunity.AccountId).get(oppLineItem.OpportunityId).add(oppLineItem);
		}
	}
}










//mapaCuentas = new Map<Id, Account>([SELECT Id, Name FROM Account]); //same thing as combining line 19.

