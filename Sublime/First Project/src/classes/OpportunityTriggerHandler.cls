/*******************************************************
File Name: AccountTrigger
Created By: Jennifer Cortes | jennifer@cipaq.com
Created Date: 07/04/2017
Description: Main trigger for the Opportunity Object
Purpose: Class that helps the OpportunityTrigger with logic
*******************************************************/

//public class OpportunityTriggerHandler {
//	public static void beforeUpdate(Map<Id, Opportunity> newMap, Map<Id, Opportunity> oldMap) { //void mens that it wont return anything

//		String userId = UserInfo.getUserId(); //creating a string variable that will hold the user ID
//		List<Task> tasksToInsert = new List<Task>(); //creating a list that will hold the Task in the variable "tasks to insert" and setting it equal to a new list that will hold the task

//		for(Id opportunityID : newMap.keySet()) { 
//			if(oldMap.get(opportunityID).StageName != 'Closed Won' && newMap.get(opportunityID).StageName == 'Closed Won') {
//				newMap.get(opportunityID).Description = 'This is a description';
//				Task t = new Task
//				(
//					OwnerId = userId,
//					Subject = 'Realizar tareas de seguimiento de este cliente',
//					Status = 'Not Started',
//					Priority = 'High',
//					WhatId = opportunityID

//				);

//				tasksToInsert.add(t); //adding the variable "t"k which holds the Task information the the new list we created called Tasks to Insert
//			}
//		}
//		insert tasksToInsert; //inserting list of tasks into the database
//	}
//}


/*********************************************************
public class OpportunityTriggerHandler {
	public static void beforeUpdate(Map<Id, Opportunity> newMap, Map<Id, Opportunity> oldMap) {

		createNewTask(newMap, oldMap);
	}

	//CALL BACK METHOD TO BE USED

	private static void createNewTask(Map<Id, Opportunity> newMap, Map<Id, Opportunity> oldMap) {
		String userId = UserInfo.getUserId(); 
		List<Task> tasksToInsert = new List<Task>();

		for(Id opportunityID : newMap.keySet()) { 
			if(oldMap.get(opportunityID).StageName != 'Closed Won' && newMap.get(opportunityID).StageName == 'Closed Won') {
				newMap.get(opportunityID).Description = 'This is opportunity was won. Hooray!';
				Task t = new Task
				(
					OwnerId = userId,
					Subject = 'Realizar tareas de seguimiento de este cliente',
					Status = 'Not Started',
					Priority = 'High',
					WhatId = opportunityID

				);

				tasksToInsert.add(t); 
			}
			
			if(newMap.get(opportunityID).StageName == 'Closed Lost') {
				newMap.get(opportunityID).Description = 'We did not win this opportunity. Boo!';
			}
			else {
				newMap.get(opportunityID).Description = 'Havent won yet. Lets keep trying';
			}
				
		}
		insert tasksToInsert; 
	}
}
*/




public class OpportunityTriggerHandler {


	public static void beforeUpdate(Map<Id, Opportunity> newMap, Map<Id, Opportunity> oldMap) {

		createNewTask(newMap, oldMap);
		initializeParentAccount(newMap, oldMap);
	}

	//CALLBACK METHOD TO CREATE AND INSERT NEW TASK

	private static void createNewTask(Map<Id, Opportunity> newMap, Map<Id, Opportunity> oldMap) {
		String userId = UserInfo.getUserId(); 
		List<Task> tasksToInsert = new List<Task>();

		for(Id opportunityID : newMap.keySet()) { 
			if(oldMap.get(opportunityID).StageName != 'Closed Won' && newMap.get(opportunityID).StageName == 'Closed Won') {
				newMap.get(opportunityID).Description = 'This is a description';
				Task t = new Task
				(
					OwnerId = userId,
					Subject = 'Realizar tareas de seguimiento de este cliente',
					Status = 'Not Started',
					Priority = 'High',
					WhatId = opportunityID

				);

				tasksToInsert.add(t); 
			}
		}
		insert tasksToInsert; 
	}

	private static void initializeParentAccount(Map<Id, Opportunity> newMap, Map<Id, Opportunity> oldMap) {
		List<Id> accountIds = new List<Id>();
		List<Account> accountsToActualize = new List<Account>();

		for(Id opportunityID : newMap.keySet()) { 
			if(oldMap.get(opportunityID).StageName != 'Negotiation/Review' && newMap.get(opportunityID).StageName == 'Negotiation/Review') {
				//Date_of_negotionation_change__c
				accountIds.add(newMap.get(opportunityID).AccountId);			
			}
		}

		if(accountIds.size() > 0) {
			accountsToActualize = [SELECT Id, Name, Negotiation_date_change__c FROM Account WHERE Id IN : accountIds ];
			for(Account acc : accountsToActualize) {
				acc.Negotiation_date_change__c = System.today();
			}
			update accountsToActualize;
		}
	}
}






















