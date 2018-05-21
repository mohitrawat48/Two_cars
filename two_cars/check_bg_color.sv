/*
Description: a background color checker module for sprites.

Purpose: It stores all the RGB values of all background colors and tells if a
 		particular pixel is a background color of a sprite (a variety of pink
		colors and white colors).


*/


module check_bg_color ( input logic [15:0] onchip_data,
								output logic is_background
							  );
		logic [15:0] bg1;
		logic [15:0] bg2;
		logic [15:0] bg3;
		logic [15:0] bg4;
		logic [15:0] bg5;
		logic [15:0] bg6;
		logic [15:0] bg7;
		logic [15:0] bg8;
		logic [15:0] bg9;
		logic [15:0] bg10;
		
		
		
								
		always_comb
		begin
		
		bg1 = ( ( ( (16'd255)  << 8 ) & (16'hF800) ) ) | ( ( (16'd174)  << 3 ) & (16'h07E0) ) 
		| ( ( (16'd201) >> 3 ) & (16'h001F) ) ;
		bg2 = ( ( ( (16'd255)  << 8 ) & (16'hF800) ) ) | ( ( (16'd255)  << 3 ) & (16'h07E0) ) 
		| ( ( (16'd255) >> 3 ) & (16'h001F) ) ;
		bg3 = ( ( ( (16'd219)  << 8 ) & (16'hF800) ) ) | ( ( (16'd147)  << 3 ) & (16'h07E0) ) 
	   | ( ( (16'd168) >> 3 ) & (16'h001F) ) ;
		bg4 = ( ( ( (16'd217)  << 8 ) & (16'hF800) ) ) | ( ( (16'd156)  << 3 ) & (16'h07E0) ) 
	   | ( ( (16'd179) >> 3 ) & (16'h001F) ) ;
		bg5 = ( ( ( (16'd255)  << 8 ) & (16'hF800) ) ) | ( ( (16'd174)  << 3 ) & (16'h07E0) ) 
	   | ( ( (16'd201) >> 3 ) & (16'h001F) ) ;
		bg6 = ( ( ( (16'd255)  << 8 ) & (16'hF800) ) ) | ( ( (16'd177)  << 3 ) & (16'h07E0) ) 
	   | ( ( (16'd203) >> 3 ) & (16'h001F) ) ;
		bg7 = ( ( ( (16'd243)  << 8 ) & (16'hF800) ) ) | ( ( (16'd166)  << 3 ) & (16'h07E0) ) 
	   | ( ( (16'd198) >> 3 ) & (16'h001F) ) ;
		bg8 = ( ( ( (16'd234)  << 8 ) & (16'hF800) ) ) | ( ( (16'd166)  << 3 ) & (16'h07E0) ) 
	   | ( ( (16'd191) >> 3 ) & (16'h001F) ) ;
		bg9 = ( ( ( (16'd255)  << 8 ) & (16'hF800) ) ) | ( ( (16'd166)  << 3 ) & (16'h07E0) ) 
	   | ( ( (16'd201) >> 3 ) & (16'h001F) ) ;
		bg10 = ( ( ( (16'd255)  << 8 ) & (16'hF800) ) ) | ( ( (16'd170)  << 3 ) & (16'h07E0) ) 
	   | ( ( (16'd200) >> 3 ) & (16'h001F) ) ;
					
					
		
		

			is_background = 0;
			
			if( ( bg1 == onchip_data) ||
				 ( bg2 == onchip_data) ||
				 ( bg3 == onchip_data) ||
				 ( bg4 == onchip_data) ||
				 ( bg5 == onchip_data) ||
				 ( bg6 == onchip_data) ||
				 ( bg7 == onchip_data) ||
				 ( bg8 == onchip_data) ||
				 ( bg9 == onchip_data) ||
				 ( bg10 == onchip_data) )
			begin
				is_background = 1;
			end
		
		
		end

		
endmodule
