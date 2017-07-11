public class AccountVF2Controller {
	//Variables
	public Id idCuenta{get; set;}
	public Account cuenta{get;set;}
	public List<Contact> contacts {get;set;}
	//public String cadena {get; set;}
	//public Integer num1 {get; set;}
	//public Integer num2 {get; set;}
	//public Integer num3 {get; set;}


	//Constructor
	public AccountVF2Controller() {
		idCuenta = ApexPages.currentPage().getParameters().get('id');
		//cadena = ApexPages.currentPage().getParameters().get('param');
		//num1 = Integer.valueOf(ApexPages.currentPage().getParameters().get('param1'));
		//num2 = Integer.valueOf(ApexPages.currentPage().getParameters().get('param2'));
		//num3 = num1 + num2;

		//SOQL
		cuenta = [SELECT Name, Type, ShippingStreet, ShippingCity, ShippingState, ShippingPostalCode, ShippingCountry, OwnerID FROM Account WHERE Id=:idCuenta];

		contacts = [SELECT FirstName, LastName, Title, Email, Phone, Department, Description 
			FROM CONTACT WHERE AccountId=:idCuenta];

	}

	public PageReference save() {
		update cuenta;
		update contacts;

		return new PageReference('/' + idCuenta);
	}

	public PageReference cancel() {

		return new PageReference('/' + idCuenta);

	}
}