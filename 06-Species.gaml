/**
* Name: Aspect
* Based on the internal empty template. 
* Author: shirint
* Tags: 
*/


model Species

// https://gama-platform.org/wiki/RegularSpecies

global {
    int stepCounterVariable <- 0 update: stepCounterVariable+1;
    
    reflex writeDebug {
    	write "Global species - World Agent - Step Counter: " + stepCounterVariable;
    }
    
    // Initialize the other agent!
    init {
    	create NewAgent;
    }
}

species NewAgent {
    int stepCounterVariableNew <- 0 update: stepCounterVariableNew+1;
    
    reflex writeDebug {
    	write "NewAgent species - Step Counter: " + stepCounterVariableNew;
    }
}

experiment myExperiment {}