//-------------------------------------------------------------------------
//      
//      
//      
//          This module literaly contains the entire game mechanics                
//          Everthing except keyboard and audio is inside this module
//                                         
//          In short,this module takes in coordinate of current pixel
//				being drawn and other relevant inputs from VGA_controller module
//     		and ouputs the 24 bit RGB value for that pixel.                                         
//                                          
//-------------------------------------------------------------------------



module VGA_manager(
    input logic Clk,
    input logic Reset,frame_clk,
	 

	 output logic [7:0]  VGA_R,VGA_G,VGA_B,			 
    
	 input logic [9:0] X_Cord,       // horizontal coordinate
                      Y_Cord,       // vertical coordinate
                        
	 //SRAM Signals
    output logic CE, UB, LB, OE, WE,
    output logic [19:0] ADDR,
    inout wire [15:0] Data, //tristate buffers need to be of type wire
	 
	 //input logic [9:0] step_x,step_y,
	 
	 input logic [7:0] player1_key, player2_key,keycode
	 
);
	
	// we are always reading
	assign CE = 1'b0;
	assign WE = 1'b1;
	assign OE = 1'b0;
	assign LB = 1'b0;
	assign UB = 1'b0;

	//internal signals for this module
	logic [15:0]data_from_tristate, data_to_tristate,data_from_lookuptable;
	
	logic 		is_car_a,
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
					is_p2;
							 
	
	logic [9:0]  	   car_a_x,car_a_y,
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
							p2_x,p2_y;   
							
							
	logic [16:0] onchip_addr;
	logic [15:0] onchip_data;
	
	logic is_background;
	
	//////
	
	logic [9:0] car_step_size_x,car_step_size_y,
					tree_step_size,startline_step_size,
					traffic_step_size,tree;
					
	assign car_step_size_x = 10'd63;
	assign car_step_size_y = 10'd100;
	
	//assign tree_step_size = 5;
	//assign startline_step_size = 1;
	//assign traffic_step_size_x = 3;
	//assign traffic_step_size_y = 3;
	
	
	/////
	
	integer car_a_speed,car_b_speed,traffic_speed,startline_speed,tree_speed;
	assign car_a_speed = 5;
	assign car_b_speed = 5;
	assign traffic_speed = 1;
	assign startline_speed = 1;
	assign tree_speed = 1;
	
	logic [9:0] redcar_XX_Pos,redcar_YY_Pos;
	logic [9:0] bluecar_XX_Pos,bluecar_YY_Pos;
	
	///
	
	logic [7:0] keycode_traffic,keycode_trees,keycode_startline;
	assign keycode_startline = 0;
	assign keycode_traffic = 8'h16;
	assign keycode_trees = 8'h16;



///// control signals
	
logic p1win,p2win,showMenu, show3, show2, show1, showGo, showp1win, showp2win;
logic [7:0] keycode_control;

always_comb
begin
		p1win = 0;
		p2win = 0;
	
		if( (is_car_a == 1) && (is_car_c == 1) )
		begin
			p2win = 1;
		end
		
		if( (is_car_b == 1) && (is_car_c == 1) )
		begin
		  p1win = 1;
		end


end



	
//game controller
control game_control(.*);
	
	
//background color
check_bg_color my_check_bg_color( .*);	
					
//lookup table
 lookup_table my_lookup_table ( .*,.DrawX(X_Cord), .DrawY(Y_Cord),
											  .sram_addr(ADDR),
											  .sram_data(data_from_tristate),
							              .final_output(data_from_lookuptable)
										 );



//objects
p2 my_p2 ( .*,.DrawX(X_Cord),.DrawY(Y_Cord),
			  .pixel_x_in_p2(p2_x),.pixel_y_in_p2(p2_y)
			 );

p1 my_p1 ( .*,.DrawX(X_Cord),.DrawY(Y_Cord),
			  .pixel_x_in_p1(p1_x),.pixel_y_in_p1(p1_y)
			 );


three my_three(.*,.DrawX(X_Cord),.DrawY(Y_Cord),
						.pixel_x_in_three(three_x), 
						.pixel_y_in_three(three_y)
					);

two my_two(.*,.DrawX(X_Cord),.DrawY(Y_Cord),
						.pixel_x_in_two(two_x), 
						.pixel_y_in_two(two_y)
					);
		
one my_one(.*,.DrawX(X_Cord),.DrawY(Y_Cord),
						.pixel_x_in_one(one_x), 
						.pixel_y_in_one(one_y)
					);
					
g_letter my_g_letter( .*,.DrawX(X_Cord),.DrawY(Y_Cord),
						.pixel_x_in_g_letter(g_x), 
						.pixel_y_in_g_letter(g_y)
					);

o_letter my_o_letter( .*,.DrawX(X_Cord),.DrawY(Y_Cord),
						.pixel_x_in_o_letter(o_x), 
						.pixel_y_in_o_letter(o_y)
					);

menu my_menu( .*,.DrawX(X_Cord),.DrawY(Y_Cord),
						.pixel_x_in_menu(menu_x), 
						.pixel_y_in_menu(menu_y)
					);
		

red_car my_red_car( .*,.DrawX(X_Cord),.DrawY(Y_Cord),.is_car(is_car_a),
							  .pixel_x_in_car(car_a_x),.pixel_y_in_car(car_a_y),
							  .keycode(player1_key),.speed(car_a_speed)
						 );
						 

										
blue_car my_blue_car( .*,.DrawX(X_Cord),.DrawY(Y_Cord),.is_car(is_car_b),
							  .pixel_x_in_car(car_b_x),.pixel_y_in_car(car_b_y),
							  .keycode(player2_key),.speed(car_b_speed)
						  );

						  
startline my_startline( .*, .step_size(tree_step_size),.DrawX(X_Cord),.DrawY(Y_Cord),            
									 .pixel_x_in_startline(startline_x),
								    .pixel_y_in_startline(startline_y),
									 .speed(tree_speed),
									 .keycode(keycode_control)
									 
							  );

tree my_tree( .*,.step_size(tree_step_size),.DrawX(X_Cord),.DrawY(Y_Cord),
					  .pixel_x_in_tree(tree_x),.pixel_y_in_tree(tree_y),
					  .keycode(keycode_control),.speed(tree_speed)
				 );

				 
traffic my_traffic(.*,.DrawX(X_Cord), .DrawY(Y_Cord),
							 .is_car(is_car_c),
							 .pixel_x_in_car(car_c_x),
							 .pixel_y_in_car(car_c_y),
							 .keycode(keycode_control),                            
							 .car_step_size_x(traffic_step_size),
							 .car_step_size_y(traffic_step_size),
							 .speed(traffic_speed)
							 );
						
		
//onchip
onchip my_onchip( .read_address(onchip_addr),.Clk(Clk),.data_Out(onchip_data) );
 
		 
// The tri-state 
tristate #(.N(16)) tr0( .Clk(Clk), .tristate_output_enable(~WE), 
								.Data_write(data_to_tristate), .Data_read(data_from_tristate),
								.Data(Data) );
	 
	 
	 

//VGA Extender

RGB_extender my_rgb_extender( .input_data(data_from_lookuptable), .R(VGA_R), .G(VGA_G), .B(VGA_B) );
 	

endmodule
