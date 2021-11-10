/**
* Name: Conditions
* Based on the internal empty template. 
* Author: shirint
* Tags: 
*/


model Conditions

// https://gama-platform.org/wiki/BasicProgrammingConceptsInGAML#conditional-structures

global {
    int testVariableIncrement <- 3 max: 6 update: testVariableIncrement+1;
    int stepCounterVariable <- 0 update: stepCounterVariable+1;
    bool flippingBooleanVariable <- true update: flip(0.5);
    
    reflex writeDebug {
    	write testVariableIncrement;
    	write stepCounterVariable;
    	write flippingBooleanVariable;
    }
    
    reflex conditionDebug {
    	if (mod(stepCounterVariable, 10) = 0 and flippingBooleanVariable) {
    		write "The step number is divisible by 10 and the boolean variable is true: " + stepCounterVariable;
		}
		else if (mod(stepCounterVariable, 10) = 0) {
    		write "The step number is divisible by 10: " + stepCounterVariable;
		}
		else if (flippingBooleanVariable) {
    		write "The boolean variable is true.";
		}
		else {
		    write "Neither the step counter is divisible by 10, nor the boolean one is true.";
		}
    }
    
}

experiment myExperiment {}