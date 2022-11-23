/**
* Name: Grid
* Based on the internal empty template. 
* Author: shirint
* Tags: 
*/


model Grid

/* Insert your model definition here */

global {
	
	int numberOfQueens <- 12;

}

    
grid ChessBoard width: numberOfQueens height: numberOfQueens { 
	init{
		if(even(grid_x) and even(grid_y)){
			color <- #black;
		}
		else if (!even(grid_x) and !even(grid_y)){
			color <- #black;
		}
		else {
			color <- #white;
		}
	}		

}

experiment NQueensProblem type: gui{
	output{
		display ChessBoard{
			grid ChessBoard border: #black ;
		}
	}
}