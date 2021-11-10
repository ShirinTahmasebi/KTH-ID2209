/**
* Name: Geometry
* Based on the internal empty template. 
* Author: shirint
* Tags: 
*/


model Geometry


experiment myExperiment type: gui {
    output {
        display myDisplay {
        	// position: top left point of the shape
            graphics "layer1" position:{25,25} size:{20,10} {
                draw shape color: #gold;
            }
            graphics "layer2" {
            	// at: center of square
                draw square(20) at: {15,15} color: #darkorange;
            }
            graphics "layer3" transparency:0.5 {
            	// at: center of square
                draw square(20) at: {55, 45} color: #cornflowerblue;
            }
        }
    }
}