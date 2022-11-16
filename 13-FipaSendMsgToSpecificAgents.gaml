/**
* Name: FipaContractNetProtocol
* Based on the internal empty template. 
* Author: shirint
* Tags: 
*/


model FipaSendMsgToSpecificAgents

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
		
	reflex sendProposalToAllBidders when: (time = 1) {
		write '(Time ' + time + '): ' + name + ' sent a public message to all bidders.';
		do start_conversation to: list(Bidder) protocol: 'no-protocol' performative: 'inform' contents: ['All Bidders: Send me your proposals!'] ;
		
		//	-----------------------------------------------------------------		
		write '(Time ' + time + '): ' + name + ' sent a private message to bidders 0 and 1.';
		do start_conversation to: list(list(Bidder)[0], list(Bidder)[1]) protocol: 'no-protocol' performative: 'inform' contents: ['Bidder 0 and 1: You are receiving my secret msg!'] ;
	}
}


species Bidder skills: [fipa] {
	reflex recieveInformFromAuctioneer when: !empty(informs) {
		int numberOfMsgs <- length(informs);
		
		// To remove a message from informs (and other similar variables), you need to read the content of the message.
		// If you forget to do so, then informs always contains some messages. In that case, the execution of the corresponding reflex never stops!
		loop informMsg over: informs {
			string recievedContent <- informMsg.contents;
			do end_conversation message: informMsg contents: ['End!'];
		}	
		write '(Time ' + time + '): ' + name + ' received ' + numberOfMsgs + ' inform messages from ';
		write '-----------------------------------------------------';				
	}
}

experiment myExperiment {}