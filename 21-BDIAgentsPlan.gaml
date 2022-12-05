/**
* Name: BDIAgents
* Based on the internal empty template. 
* Author: shirint
* Tags: 
*/

// https://gama-platform.org/wiki/BDIAgents_step2
// https://gama-platform.org/wiki/1.8.1/BuiltInArchitectures

model BDIAgents

global {
	
    
    string lookingForStageString <- "Looking for an interesting stage";
    predicate lookingForStage <- new_predicate(lookingForStageString);
    
    string foundStageWithMusicString <- "Found a stage with music";
    predicate foundStageWithMusic <- new_predicate(foundStageWithMusicString);
    
    int numberOfPeople <- 10;
	int numberOfStages <- 5;
	
	init {
		create Person number:numberOfPeople;
		create Stage number:numberOfStages;
    }
}

species Person skills: [moving] control: simple_bdi {
	int viewDistance <- 10; // The furthest distance that a person can ssee.
	bool isInterestedInMusic <- flip(0.5);
	bool isInterestedInCrowdedPlaces <- flip(0.5);
	
	init {
		if (isInterestedInMusic) {
			// At this moment, the intention list is empty. So, the first item in the desire list will be added to the intention list.
			// In other words, here, the first intention is equal to the first desire--lookingForStage.
    		do add_desire(lookingForStage);
        }
    }
    
	aspect base {
		rgb agentColor <- rgb("green");
		
		if (isInterestedInMusic and isInterestedInCrowdedPlaces) {
			agentColor <- rgb("red");
		} else if (isInterestedInMusic) {
			agentColor <- rgb("darkorange");
		} else if (isInterestedInCrowdedPlaces) {
			agentColor <- rgb("purple");
		}
				
      	draw circle(1) color: agentColor border: #black;
      	draw circle(viewDistance) color: agentColor border: #black wireframe: true;
	}
	
	// Plan for achieving the 'lookForStage' intention 
	plan move intention: lookingForStage {
		do wander;
	}
}

species Stage {
	bool hasMusic <- true;
	bool isCrowded <- flip(0.5);	
	
	aspect base {
		draw square(3) color: rgb("darkgreen");
	}
}

experiment myExperiment type:gui {
	output {
		display myDisplay {
			species Person aspect:base;
			species Stage aspect:base;
		}
	}
}