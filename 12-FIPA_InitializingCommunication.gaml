/**
* Name: FIPAInitializingCommunication
* Based on the internal empty template. 
* Author: shirint
* Tags: 
*/

model FIPAInitializingCommunication

// https://gama-platform.org/wiki/BuiltInSkills#fipa


/*
 * We can use different protocols for the interaction between agents:
 * 
 * 		- 'no-protocol': A freestyle interaction protocol in which the modeler
 * 				(1) can send whatever type of message (i.e., message performative) in the corresponding conversation
 * 				(2) is responsible for marking the end of the conversation by sending a message with 'end_conversation' performative. 
 * 
 * 		- 'fipa-contract-net': https://pade.readthedocs.io/en/latest/_images/seq_diag_contract.png
 */

global {
	int numberOfBidders <- 5;	
	
	init {
		create Auctioneer;
		create Bidder number: numberOfBidders;
	}
}



species Auctioneer skills: [fipa] {
	bool canStart <- false;
	
	reflex initialize when: (time = 0) {
		write '(Time ' + time + '): OK! Ready to start?';
		do start_conversation to: list(Bidder) protocol: 'no-protocol' performative: 'inform' contents: ['Can you hear me?'] ;	
		write '-----------------------------------------------------';
	}
	
	reflex recieveInforms when: !empty(informs) {
		write '-----------------------------------------------------';
		loop informMsg over: informs {
			write '(Time ' + time + '): ' + name + ' received a confirm message from ' + agent(informMsg.sender).name + ' with content: ' + informMsg.contents;
			do agree message: informMsg contents: ['Agree.'] ;			
		}
		write '-----------------------------------------------------';				
	}
}


species Bidder skills: [fipa] {
	
	reflex recieveInforms when: !empty(informs) {
		message informMsg <- informs[0];
		write '(Time ' + time + '): ' + name + ' received an infrom message from ' + agent(informMsg.sender).name + ' with content: ' + informMsg.contents;
		do inform message:informMsg contents: ['Yes.'];
		write '-----------------------------------------------------';				
	}
	
	reflex recieveAgrees when: !empty(agrees) {
		message agreeMsg <- agrees[0];
		write '(Time ' + time + '): ' + name + ' received an agree message from ' + agent(agreeMsg.sender).name + ' with content: ' + agreeMsg.contents;
		do end_conversation message:agreeMsg contents: ['End!'] ;
		write '-----------------------------------------------------';				
	}
}

experiment myExperiment {}