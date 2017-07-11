/*******************************************************
File Name: AccountTrigger
Created By: Jennifer Cortes | jennifer@cipaq.com
Created Date: 07/04/2017
Description: Class that helps the AccountTrigger with logic
*******************************************************/


public class AccountTriggerHandler {
	public static void beforeInsert(List<Account> newList) {
		for(Account item : newList) { //for look for account item that is in the trigger.new //as a paramteter its receiving a list with the account
			if(item.Copy_Shipping_Address__c ) {
				item.ShippingStreet = item.BillingStreet;
				item.ShippingCity = item.BillingCity;
				item.ShippingState = item.BillingState;
				item.ShippingPostalCode = item.BillingPostalCode;
				item.ShippingCountry = item.BillingCountry;	
			}
		}
	}

	//Map = Dictionary in Python. This will be receicing 2 dictionaries. They Key will be the ID, the value will be the ACCOUNT info within that ID.
	public static void beforeUpdate(Map<Id, Account> newMap, Map<Id, Account> oldMap) { 
		//for look for account item that is in the trigger.new //as a paramteter its receiving a list with the account
		for(Id accountID : newMap.keySet()) { 

			if(oldMap.get(accountID).Copy_Shipping_Address__c == false && newMap.get(accountID).Copy_Shipping_Address__c==true) {
				newMap.get(accountID).ShippingStreet = newMap.get(accountID).BillingStreet;
				newMap.get(accountID).ShippingCity = newMap.get(accountID).BillingCity;
				newMap.get(accountID).ShippingState = newMap.get(accountID).BillingState;
				newMap.get(accountID).ShippingPostalCode = newMap.get(accountID).BillingPostalCode;
				newMap.get(accountID).ShippingCountry = newMap.get(accountID).BillingCountry;	
			}
		}
	}



	public static void beforeUpdate(List<Account> newList, Map<Id, Account> oldMap) {
		for(Account acc: newList) {
			if(acc.Copy_Shipping_Address__c && !oldMap.get(acc.Id).Copy_Shipping_Address__c) {
				acc.ShippingStreet = acc.BillingStreet;
			}
		}
	}
}