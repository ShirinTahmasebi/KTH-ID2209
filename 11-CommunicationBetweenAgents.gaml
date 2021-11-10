/**
* Name: CommunicationBetweenAgents
* Based on the internal empty template. 
* Author: shirint
* Tags: 
*/


model CommunicationBetweenAgents

// https://gama-platform.org/wiki/InteractionBetweenAgents

global {
	int numberOfPeople <- 30;
	int numberOfStores <- 5;
	int distanceThreshold <- 10;
	
	init {
		create Person number:numberOfPeople;
		create Store number:numberOfStores;
				
		// ------------------ START OF THE NEW PART ------------------
		loop counter from: 1 to: numberOfPeople {
        	Person my_agent <- Person[counter - 1];
        	my_agent <- my_agent.setName(counter);
        }
		
		loop counter from: 1 to: numberOfStores {
        	Store my_agent <- Store[counter - 1];
        	my_agent <- my_agent.setName(counter);
        }
        // ------------------ END OF THE NEW PART ------------------   
	}
}



species Person skills: [moving] {
	bool isHungry <- false update: flip(0.5);
	bool isThirsty <- false update: flip(0.5);
	string personName <- "Undefined";
	
	// ------------------ START OF THE NEW PART ------------------
	action setName(int num) {
		personName <- "Person " + num;
	}
    // ------------------ END OF THE NEW PART ------------------   
	
	aspect base {
		rgb agentColor <- rgb("green");
		
		if (isHungry and isThirsty) {
			agentColor <- rgb("red");
		} else if (isThirsty) {
			agentColor <- rgb("darkorange");
		} else if (isHungry) {
			agentColor <- rgb("purple");
		}
		
		draw circle(1) color: agentColor;
	}
	
	reflex move {
		do wander;
	}
	
	// ------------------ START OF THE NEW PART ------------------	
	reflex reportApproachingToStore when: !empty(Store at_distance distanceThreshold) {
		ask Store at_distance distanceThreshold {
			write myself.personName + " is near " + self.storeName ;
		}
	}
	// ------------------ END OF THE NEW PART ------------------   
}

species Store {
	// It doesn't make sense to have a store without any food and drink. It is just for demo!
	bool hasFood <- flip(0.5);
	bool hasDrink <- flip(0.5);	
	string storeName <- "Undefined";
	
	// ------------------ START OF THE NEW PART ------------------
	action setName(int num) {
		storeName <- "Store " + num;
	}
    // ------------------ END OF THE NEW PART ------------------   
	
	aspect base {
		rgb agentColor <- rgb("lightgray");
		
		if (hasFood and hasDrink) {
			agentColor <- rgb("darkgreen");
		} else if (hasFood) {
			agentColor <- rgb("skyblue");
		} else if (hasDrink) {
			agentColor <- rgb("lightskyblue");
		}
		
		draw square(2) color: agentColor;
	}
}

experiment myExperiment type:gui {
	output {
		display myDisplay {
			species Person aspect:base;
			species Store aspect:base;
		}
	}
}
