/**
* Name: ActionAndBehaivor
* Based on the internal empty template. 
* Author: shirint
* Tags: 
*/


model ActionAndBehaivor

// https://gama-platform.org/wiki/DefiningActionsAndBehaviors

global {
	int numberOfPeople <- 30;
	int numberOfStores <- 5;
	
	init {
		create Person number:numberOfPeople;
		create Store number:numberOfStores;
	}	
}

species Person {
	bool isHungry <- false update: flip(0.5);
	bool isThirsty <- false update: flip(0.5);
	
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
	
	// ------------------ START OF THE NEW PART ------------------
	reflex callActions {
		do doSomethingWithoutReturn(rnd(1, numberOfPeople));
		int result <- doSomethingWithReturn(rnd(1, numberOfPeople, 5)); // Step is 5.
		write "Action 2 is finished. The result is: " + result;
	}
	
	action doSomethingWithoutReturn(int dummyInput) {
		write "Person Action 1 - The dummy input is:" + dummyInput;
	}
	
	int doSomethingWithReturn(int dummyInput) {
		write "Person Action 2 - The dummy input is:" + dummyInput;
		return dummyInput;
	}
	// ------------------ END OF THE NEW PART ------------------
}

species Store {
	// It doesn't make sense to have a store without any food and drink. It is just for demo!
	bool hasFood <- flip(0.5);
	bool hasDrink <- flip(0.5);	
	
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