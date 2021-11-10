/**
* Name: Loops
* Based on the internal empty template. 
* Author: shirint
* Tags: 
*/


model Loops

// https://gama-platform.org/wiki/Statements#loop

global {
    int stepCounterVariable <- 0 update: stepCounterVariable+1;
    bool flippingBooleanVariable <- true update: flip(0.5);
    
    reflex writeDebug {
    	write stepCounterVariable;
    	write flippingBooleanVariable;
    }
    
    reflex timesLoop {
    	loop times: stepCounterVariable {
    		write "Repetetive Logic - Times Loop";
    	}
    }
    
    reflex whileLoop {
    	loop while: stepCounterVariable < 5 {
    		write "Repetetive Logic - While Loop - Still the counter is less than 5.";
    		// It doesn't make sense at all to use break in such a while loop. Just for demo!
    		break;
    	}
    }
    
    reflex fromToLoop {
    	loop counter from: 1 to: stepCounterVariable {
    		write "Repetetive Logic - From..To Loop - Counter: " + counter;
    	}
    }
    
    reflex fromToStepLoop {
    	loop counter from: 1 to: stepCounterVariable step: 2 {
    		write "Repetetive Logic - From..To Loop with Step 2 - Counter: " + counter;
    	}
    }
    
    reflex iterateOverLoop {
    	loop item over: [10, 20, 30, 40] {
			write "Repetetive Logic - Iterate Over - Item is: " + item;    	
		}
    }
}

experiment myExperiment {}
