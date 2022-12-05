/**
* Name: BDIAgents
* Based on the internal empty template. 
* Author: shirint
* Tags: 
*/


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
	int viewDistance <- 10;
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
	
	// ------------------ START OF THE NEW PART ------------------
	
	// Perception and percieve function
	// A perception is a function executed at each iteration to update the agent's Belief base, 
	// to know the changes in its environment (the world, the other agents and itself). 
	// The agent can perceive other agents up to a fixed distance.
	
	// The darkorange agents will stop after they find a music stage.
	perceive target: Stage where (each.hasMusic = true and self.isInterestedInMusic and not self.isInterestedInCrowdedPlaces) in: viewDistance {
        focus id:foundStageWithMusicString var:location;
        ask myself {
			// Myself: Stage
			// Self: Person
            do remove_intention(lookingForStage, true);
        }
    }
	
	// The red agents will continue wnadering even after they find a music stage.
	perceive target: Stage where (each.hasMusic = true and self.isInterestedInMusic and self.isInterestedInCrowdedPlaces) in: viewDistance {
        focus id:foundStageWithMusicString var:location;
        ask myself {
            do remove_intention(lookingForStage, false);
        }
    }
	// ------------------ END OF THE NEW PART ------------------
    
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