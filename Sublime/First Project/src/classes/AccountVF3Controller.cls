public class AccountVF3Controller {
	public Id idCuenta {get;set;}
	public Account cuenta {get;set;}
	public List<contact> contacts {get;set;}

	public AccountVF3Controller(apexpages.StandardController sc) {
		idCuenta = sc.getId();
		cuenta = (Account)sc.getRecord();


		contacts = [SELECT FirstName, LastName, Title, Email, Phone, Department, Description 
			FROM CONTACT WHERE AccountId=:idCuenta];

	}

	public void newContact()  {
		Contact c = new Contact();
		c.FirstName = 'Ron';
		c.LastName = 'Weasley';
		c.AccountId = idCuenta;
		contacts.add(c);
	}


	
	public PageReference save() {
		
		for(Contact item : contacts) {

		}
		update cuenta;
		upsert contacts;

		return new PageReference('/' + idCuenta);
	}

	public PageReference cancel() {

		return new PageReference('/' + idCuenta);

	}
}