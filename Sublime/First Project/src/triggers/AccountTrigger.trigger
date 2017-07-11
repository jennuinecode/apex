/*******************************************************
File Name: AccountTrigger
Created By: Jennifer Cortes | jennifer@cipaq.com
Created Date: 07/04/2017
Description: Main trigger for the Account Object
Purpose: Trigger to auto populate shipping address by copying info entered into billing address field.
*******************************************************/


//ONLY TAKES FIRST RECORD UPLOADED**********************
//trigger AccountTrigger on Account (before insert) {
//	//trigger.new is a list that brings over values from event (insert, update, delete, etc.) object*/
//	if (Trigger.New[0].Copy_Shipping_Address__c == true) {
//		Trigger.New[0].ShippingStreet = Trigger.New[0].BillingStreet;
//	} 
//	else {

//	}
//}

//TAKES ALL THE RECORDS THAT COME IN THE LIST 
//METHOD 1

//trigger AccountTrigger on Account (before insert) {

//	if(Trigger.isBefore) {
//		if(Trigger.isInsert) {
//			for(Account item : Trigger.New) { 
//				if(item.Copy_Shipping_Address__c ) {
//					item.ShippingStreet = item.BillingStreet;
//					item.ShippingCity = item.BillingCity;
//					item.ShippingState = item.BillingState;
//					item.ShippingPostalCode = item.BillingPostalCode;
//					item.ShippingCountry = item.BillingCountry;	
//				}
//			}
//		}
//	}

//}

//METHOD 2
trigger AccountTrigger on Account (before insert, before update) {

	if(Trigger.isBefore) {
		if(Trigger.isInsert) {
			AccountTriggerHandler.beforeInsert(Trigger.New);
		}
		if(Trigger.isUpdate) {
			AccountTriggerHandler.beforeUpdate(Trigger.newMap, Trigger.oldMap);
		}
	}
}





