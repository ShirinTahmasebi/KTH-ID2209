/**
* Name: FipaContractNetProtocol
* Based on the internal empty template. 
* Author: shirint
* Tags: 
*/


model FipaContractNetProtocol

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
		do start_conversation to: list(Bidder) protocol: 'fipa-contract-net' performative: 'cfp' contents: ['All Bidders: Send me your proposals!'] ;
	}
	
	reflex receive_refuse_messages when: !empty(refuses) {
		loop refuseMsg over: refuses {
			write '(Time ' + time + '): ' + agent(refuseMsg.sender).name + ' refused.';
			
			// Read content to remove the message from refuses variable.
			string dummy <- refuseMsg.contents[0];
		}
	}
	
	reflex recieveProposals when: !empty(proposes) {
		loop proposeMsg over: proposes {			
			if (agent(proposeMsg.sender).name = "Bidder1") {
				do reject_proposal message: proposeMsg contents: ['Sorry!'];
			} else {
				do accept_proposal message: proposeMsg contents: ['Great! Inform me.'];
			}
			
			
			// Read content to remove the message from proposes variable.
			string dummy <- proposeMsg.contents;
		}
	}
}


species Bidder skills: [fipa] {
	reflex recieveCalls when: !empty(cfps) {
		loop cfpMsg over: cfps {
			write '(Time ' + time + '): ' + name + ' receives a cfp message from ' + agent(cfpMsg.sender).name + ' with content: ' + cfpMsg.contents;
			
			if (name = 'Bidder0') {
				do refuse message: cfpMsg contents:["Too busy to work on this. " + name];
			} else {
				do propose message: cfpMsg contents:["Proposal from " + name];
			}
			
		}
	}
	
	// ------------------ START OF THE NEW PART ------------------
	reflex recieveRejectProposals when: !empty(reject_proposals) {
		write('reject_proposals');		
		loop rejectMsg over: reject_proposals {
			write '(Time ' + time + '): ' + name + ' is rejected.';
			
			// Read content to remove the message from reject_proposals variable.
			string dummy <- rejectMsg.contents[0];
		}
	}
	
	reflex recieveAcceptProposals when: !empty(accept_proposals) {		
		write('accept_proposals');		
		loop acceptMsg over: accept_proposals {
			write '(Time ' + time + '): ' + name + ' is accepted.';
			do inform message: acceptMsg contents:["Inform from " + name];
			
			// Read content to remove the message from accept_proposals variable.
			string dummy <- acceptMsg.contents[0];
		}
	}
	// ------------------ END OF THE NEW PART ------------------
	
}

experiment myExperiment {}