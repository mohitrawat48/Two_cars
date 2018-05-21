/*

Description: It stores all the addresses of sprites stored on on-chip memory and
 		SRAM. It takes two input from all objects, one tells if a pixel belongs
to an object, the other gives the offset sprite coordinate. It also
switches between on-chip and SRAM based on the
input control signal. It also takes another input which tells if a pixel
from on-chip is a background color of a sprite. It outputs the 16-bit
wide data to RGB_extender.sv. 
Purpose: To access data from the correct address from on-chip or SRAM.

*/


module lookup_table ( input logic Clk,
							
							 input logic [9:0] DrawX, DrawY,
							 
							 input logic 		is_car_a,
													is_car_b,
													is_car_c,
											//		is_bike,
													is_tree,
													is_startline,
													is_three,
													is_two,
													is_one,
													is_g,
													is_o,
													is_menu,
													is_p1,
							                  is_p2,
													
							 input logic [9:0]   car_a_x,car_a_y,
												   	car_b_x,car_b_y,
														car_c_x,car_c_y,
												//		bike_x,bike_y,
														tree_x,tree_y,
														startline_x,startline_y,
														three_x,three_y,
														two_x,two_y,    
														one_x,one_y,   
														g_x,g_y,          
														o_x,o_y,         
														menu_x,menu_y,
														p1_x,p1_y,			
														p2_x,p2_y,
														
							 output logic [16:0] onchip_addr,
							 input logic  [15:0] onchip_data,
														
							 output logic [19:0] sram_addr,
							 input logic  [15:0] sram_data,
							 
							 output logic [15:0] final_output,
							 
							 input logic is_background,
							 
							 input logic showMenu, show3, show2, show1, showGo, showp1win, showp2win

							 
							 );
	
	parameter [16:0]car_a_onchip_x = 10'd14;
	parameter [16:0]car_a_onchip_y = 10'd0;	
	
	parameter [16:0]car_b_onchip_x = 10'd92;
	parameter [16:0]car_b_onchip_y = 10'd0;	
	
	parameter [16:0]car_c_onchip_x = 10'd154;
	parameter [16:0]car_c_onchip_y = 10'd0;

	parameter [16:0]bike_onchip_x = 10'd258;
	parameter [16:0]bike_onchip_y = 10'd0;

	parameter [16:0]tree_onchip_x = 10'd206;
	parameter [16:0]tree_onchip_y = 10'd0;

	parameter [16:0] default_onchip_x = 10'd504;
	parameter [16:0] default_onchip_y = 10'd181;
	
	parameter [16:0] onchip_size_x = 10'd283;
	parameter [16:0] onchip_size_y = 10'd100;
	
	parameter [19:0] startline_sram_x = 10'd0;
	parameter [19:0] startline_sram_y = 10'd486;

	parameter [19:0] three_sram_x = 10'd171;
	parameter [19:0] three_sram_y = 10'd571;

	parameter [19:0] two_sram_x = 10'd85;
	parameter [19:0] two_sram_y = 10'd570;
	
	parameter [19:0] one_sram_x = 10'd0;
	parameter [19:0] one_sram_y = 10'd570;
	
	parameter [19:0] g_sram_x = 10'd256;
	parameter [19:0] g_sram_y = 10'd571;
	
	parameter [19:0] o_sram_x = 10'd340;
	parameter [19:0] o_sram_y = 10'd571;
	
	parameter [19:0] menu_sram_x = 20'd0;
	parameter [19:0] menu_sram_y = 20'd676;
	
	parameter [19:0] p1_sram_x = 	   20'd0;     //10'd0;		
	parameter [19:0] p1_sram_y = 		20'd1162;  //10'd570;	
	                                                  
	parameter [19:0] p2_sram_x = 		20'd0;     //10'd0;		
	parameter [19:0] p2_sram_y = 		20'd1264;  //10'd676;	
	
	parameter [19:0] sram_size_x = 20'd640;
	parameter [19:0] sram_size_y = 20'd565;
	
//	parameter [15:0] tree_background = 16'hFFFF;
//	parameter [15:0] pink_background = {5'b11111,6'b101011,5'b11001};
	
	logic [16:0] onchip_out_x;
	logic [16:0] onchip_out_y;
	
	logic [19:0] sram_out_x;
	logic [19:0] sram_out_y;
		
	logic [19:0] XX_Cord ;
	assign XX_Cord = {10'b0 , DrawX};
	
	logic [19:0] YY_Cord ;
	assign YY_Cord = {10'b0 , DrawY};
	
	assign sram_addr = sram_out_y * sram_size_x + sram_out_x ;

	assign onchip_addr = onchip_out_y * onchip_size_x + onchip_out_x ;
	
	
	always_comb
	begin

		onchip_out_x = default_onchip_x;
		onchip_out_y = default_onchip_y;
	
		sram_out_x = XX_Cord;
		sram_out_y = YY_Cord;
		
		final_output = sram_data;
		
		if( is_startline )
		begin
		sram_out_x = startline_sram_x + {10'b0,startline_x};
		sram_out_y = startline_sram_y + {10'b0,startline_y};
		end
		
		if( is_menu && showMenu)
		begin
		sram_out_x = menu_sram_x + {10'b0,menu_x};
		sram_out_y = menu_sram_y + {10'b0,menu_y};
		end
		
		if( is_three && show3)
		begin
		sram_out_x = three_sram_x + {10'b0,three_x};
		sram_out_y = three_sram_y + {10'b0,three_y};
		end
		
		if( is_two && show2)
		begin
		sram_out_x = two_sram_x + {10'b0,two_x};
		sram_out_y = two_sram_y + {10'b0,two_y};
		end
		
		if( is_one && show1)
		begin
		sram_out_x = one_sram_x + {10'b0,one_x};
		sram_out_y = one_sram_y + {10'b0,one_y};
		end
		
		if( is_g && showGo)
		begin
		sram_out_x = g_sram_x + {10'b0,g_x};
		sram_out_y = g_sram_y + {10'b0,g_y};
		end
		
		if( is_o && showGo)
		begin
		sram_out_x = o_sram_x + {10'b0,o_x};
		sram_out_y = o_sram_y + {10'b0,o_y};
		end
		
		
		if( is_car_a )
		begin
		onchip_out_x = car_a_onchip_x + car_a_x ; 
		onchip_out_y = car_a_onchip_y + car_a_y ;
		end
		
		if( is_car_b && !(is_car_a) )
		begin
		onchip_out_x = car_b_onchip_x + car_b_x ; 
		onchip_out_y = car_b_onchip_y + car_b_y ;
		end
		
		if( is_car_c )
		begin
		onchip_out_x = car_c_onchip_x + car_c_x ; 
		onchip_out_y = car_c_onchip_y + car_c_y ;
		end
		
		
		if( ( is_car_a || is_car_b || is_tree || is_car_c ) && !(is_background) && !(showMenu)
				&& !(showp2win)  && !(showp1win) )
		begin
			final_output = onchip_data;
		end
		
		if( is_tree )
		begin
		onchip_out_x = tree_onchip_x + tree_x ; 
		onchip_out_y = tree_onchip_y + tree_y ;
		end
		 
		if( is_p1 && showp1win )
		begin
			sram_out_x = p1_sram_x + {10'b0,p1_x};
			sram_out_y = p1_sram_y + {10'b0,p1_y};
		end
		
		if(!(is_p1) && showp1win )
		begin
			sram_out_x = 0;
			sram_out_y = 1164;
		end
		
		if( is_p2 && showp2win )
		begin
			sram_out_x = p2_sram_x + {10'b0,p2_x};
			sram_out_y = p2_sram_y + {10'b0,p2_y};
		end
		
		if(!(is_p2) && showp2win )
		begin
			sram_out_x = 0;
			sram_out_y = 1164;
		end
		
	end
	
	
	
	

endmodule
