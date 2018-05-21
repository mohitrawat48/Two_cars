/*

	Description: It takes in 15-bit input data, and extends it to 24-bit RGB value
 		required by VGA monitor.
Purpose: We compressed the 24-bit RGB values from the sprite to 16-bit data
 	      in order to fit one pixel at one address of SRAM. We lose some color
      accuracy but it’s not noticeable. The compressed version of 24-bit
      RGB is made by taking 5 MSBs of Red, 6 MSBs of Green, and 5
      MSBs of Blue. The RGB_extender appends zeros at relevant positions    
      In the 16-bit data and makes it a 24-bit for VGA monitor. 



*/


module RGB_extender (
		
	input logic [15:0] input_data,
	output logic [7:0] R,G,B

	);
		
	logic [7:0] RR ;
	assign RR	= { input_data[15:11], 3'b000};
	
	logic [7:0] GG ;
	assign GG	= { input_data[10:5], 2'b00};
	
	logic [7:0] BB ;
	assign BB	= { input_data[4:0], 3'b000};
	
	assign R = RR;
	assign G = GG;
	assign B = BB;
	
endmodule
	