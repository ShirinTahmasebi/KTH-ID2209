/**
* Name: ScopeVariables
* Based on the internal empty template. 
* Author: shirint
* Tags: 
*/


model DrawSpecies

// https://gama-platform.org/wiki/RegularSpecies
// List of colors: https://gama-platform.org/wiki/Index#constants-and-colors

global {
	int numberOfPeople <- 30;
	int numberOfStores <- 5;
	
	// All the statements under this init scope will be computed once, at the begining of our simulation. 
	init {
		create Person number:numberOfPeople;
		create Store number:numberOfStores;
	}	
}

species Person {
	bool isHungry <- false update: flip(0.5);
	bool isThirsty <- false update: flip(0.5);
	
	// Visual Aspect
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
}

species Store {
	// It doesn't make sense to have a store without any food and drink. It is just for demo!
	bool hasFood <- flip(0.5);
	bool hasDrink <- flip(0.5);	
	
	// Visual Aspect
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
			// Display the species with the created aspects
			species Person aspect:base;
			species Store aspect:base;
		}
	}
}