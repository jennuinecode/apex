public class PDFMailerController {
		public Id accountId {get;set;}

	public PDFMailerController() {
		accountId = ApexPages.currentPage().getParameters().get('id');

	}

	public PageReference mailPDF() {
		Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();

		//Reference the attachment page and pass in the account ID
		PageReference pdf = Page.AccountsContactPDF; //visualforce page that is rendering the pdf
		pdf.getParameters().put('id', (String)accountId);
		pdf.setRedirect(true);

		//Take the PDF content
		Blob pdfContent = pdf.getContent();

		//Create the email attachment
		Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
		efa.setFileName('AccountsAndContacts.pdf');
		efa.setBody(pdfContent);

		Account account = [SELECT Email_For_PDF__c FROM Account WHERE Id =: accountId];
		String addresses = account.Email_For_PDF__c;
		String[] toAddresses = addresses.split(':', 0);

		//Sets paramteres of email
		email.setSubject('PDF Email of Accounts and Contacts');
		email.setToAddresses(toAddresses);
		email.setPlainTextBody('You have received a PDF');
		email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});

		//Sends the email
		Messaging.SendEmailResult [] r =
			Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});

		return new PageReference('/' + accountId);
	}
}