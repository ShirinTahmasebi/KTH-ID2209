/**
* Name: NQueenGrid
* Based on the internal empty template. 
* Author: shirint
* Tags: 
*/


model NQueenGrid


global {
	
	int numberOfQueens <- 12;

	init {
		int index <- 0;
		create Queen number: numberOfQueens;
		
		loop counter from: 1 to: numberOfQueens {
        	Queen queen <- Queen[counter - 1];
        	queen <- queen.setId(index);
        	queen <- queen.initializeCell();
        	index <- index + 1;
        }
	}
}


species Queen skills: [fipa]{
    
	ChessBoard myCell; 
	int id; 
	int index <- 0;
       
    reflex updateCell {
    	write('id' + id);
    	write('X: ' + myCell.grid_x + ' - Y: ' + myCell.grid_y);
    	myCell <- ChessBoard[myCell.grid_x,  mod(index, numberOfQueens)];
    	location <- myCell.location;
    	index <- index + 1;
    }

	action setId(int input) {
		id <- input;
	}
	
	action initializeCell {
		myCell <- ChessBoard[id, id];
	}
	
	float size <- 30/numberOfQueens;
	
	aspect base {
        draw circle(size) color: #blue ;
       	location <- myCell.location ;
    }

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
			species Queen aspect: base;
		}
	}
}