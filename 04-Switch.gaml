/**
* Name: Switch
* Based on the internal empty template. 
* Author: shirint
* Tags: 
*/


model Switch

// https://gama-platform.org/wiki/Statements#match

global {
    int stepCounterVariable <- 0 update: stepCounterVariable+1;
    bool flippingBooleanVariable <- true update: flip(0.5);
    
    reflex writeDebug {
    	write stepCounterVariable;
    	write flippingBooleanVariable;
    }
    
    reflex switchBlock {
    	switch stepCounterVariable { 
    		// Start Inclusive and End Inclusive!
    		// Here, the number 2 is considered in two blocks.
			match_between [1,2] { write "The step counter is in the range: [1,2]"; } 
			match_between [2,5] { write "The step counter is in the range: [2,5]"; }
			default { write "The step counter is not in the range: [1,5]"; }
		}
    }
}

experiment myExperiment {}