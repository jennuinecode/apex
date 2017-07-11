public class AccountsContactPDFController {

	public Id accountId {get;set;}
	//public Account accountVar {get; set;} //creating variable of type: Account and naming it "accountVar"
	//public List<Contact> contactVar {get;set;} //creating variable of type: List for the contact object that will hold list of contacts 

	public AccountsContactPDFController() {
		accountId = ApexPages.currentPage().getParameters().get('id'); //how to retreive ID from the url of the object/user that initiated it
		


		//account=[SELECT Name, Type, Website, ShippingStreet, ShippingCity, ShippingState, ShippingPostalCode, ShippingCountry, Description, Industry, Owner.Name, Phone
		//			FROM Account
		//			WHERE Id =: idForAccount];

		//contacts=[SELECT Name, Title, Department, Salutation, Birthdate, Email
		//			FROM Contact
		//			WHERE Id =: idForAccount];

	}

	public Account getAccount() {
		return [SELECT Name, Type, Website, ShippingStreet, ShippingCity, ShippingState, ShippingPostalCode, ShippingCountry, Description, Industry, Owner.Name, Phone
				FROM Account
				WHERE Id =: accountId];
	}

	public List<Contact> getContacts() {
		return [SELECT Name, Title, Department, Salutation, Birthdate, Email
				FROM Contact
				WHERE Id =: accountId];
	}
}