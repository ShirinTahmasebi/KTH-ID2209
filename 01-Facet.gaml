/**
* Name: Facet
* Based on the internal empty template. 
* Author: shirint
* Tags: 
*/


model Facet

// https://gama-platform.org/wiki/BasicProgrammingConceptsInGAML#declare-variables-using-facet 

global {
	// Here, max and update are two examples of facets.
    int testVariableIncrement <- 3 max: 6 update: testVariableIncrement+1;
    int stepCounterVariable <- 0 update: stepCounterVariable+1;
    bool flippingBooleanVariable <- true update: flip(0.5);
    
    reflex writeDebug {
    	write testVariableIncrement;
    	write stepCounterVariable;
    	write flippingBooleanVariable;
    }
}

experiment myExperiment {}