/**
* Name: Variables
* Based on the internal empty template. 
* Author: shirint
* Tags: 
*/


model Variables

// https://gama-platform.org/wiki/BasicProgrammingConceptsInGAML#variables

global {
    int integerVariable <- 3;
    float floatVariable <- 2.5;
    string stringVariable <- "test"; // you can also write simple ' : <- 'test'
    bool booleanVariable <- true; // or false
    
    reflex writeDebug {
    	write integerVariable;
    	write floatVariable;
    	write stringVariable;
    	write booleanVariable;
    }
}

experiment myExperiment {}