/*

Description: It instantiates three yellow cars and sends them from the top of the
 		screen at random. It also instantiates a control state machine which
controls the motion of the three yellow cars based on random
values. Every lane has different seed value in order to randomize the traffic. 

Purpose: Encapsulates the dynamics of all three cars in one particular lane.




*/

module lane(		input  logic   	   Clk,                
													Reset,              
													frame_clk,          
						input  logic  [9:0]  DrawX, DrawY,
						output logic  			is_car,             // Whether current pixel (DrawX, DrawY) belongs to ball or background
						output logic  [9:0]  pixel_x_in_car, pixel_y_in_car,
					   input  logic  [7:0]  keycode,
						input  logic  [9:0]  car_step_size_x,
						input  logic  [9:0]  car_step_size_y,
						input integer speed,
				
						input integer yellowcar_XX_default, 
						
						input integer yellowcar1_Y_default,
						input integer yellowcar2_Y_default,
						input integer yellowcar3_Y_default,
											
						input integer yellowcar_X_Min, 		
						input integer yellowcar_X_Max, 		
						
						input integer yellowcar1_Y_Min,		
						input integer yellowcar2_Y_Min,
						input integer yellowcar3_Y_Min,
		                  
                  input integer yellowcar1_Y_Max,
                  input integer yellowcar2_Y_Max,
                  input integer yellowcar3_Y_Max,

						input	logic [9:0] redcar_XX_Pos,redcar_YY_Pos,
						input logic [9:0] bluecar_XX_Pos,bluecar_YY_Pos,
						
						
						input logic [31:0] seed


						);

	integer yellowcar1_Y_Pos;
	integer yellowcar2_Y_Pos;
	integer yellowcar3_Y_Pos;
	
	logic [7:0] keycode_s1,keycode_s2,keycode_s3;
	
	logic is_car1,is_car2,is_car3;
	
	logic [9:0] pixel_x_in_car1,pixel_y_in_car1;
	logic [9:0] pixel_x_in_car2,pixel_y_in_car2;
	logic [9:0] pixel_x_in_car3,pixel_y_in_car3;
	

	integer yellowcar_X_default;
	
	
	logic [2:0] rand_a;
	logic rand_b;
	

	
	random_num my_rand(.*,.rand_a_num(rand_a),.rand_b_num(rand_b) ); 

	always_comb
	begin
		
		if(rand_b)
			yellowcar_X_default = yellowcar_XX_default;
			
		else
			yellowcar_X_default = yellowcar_XX_default + 63;
	
	end

	yellow_car my_yellow_car1( .*,.is_car(is_car1),
											.pixel_x_in_car(pixel_x_in_car1),
											.pixel_y_in_car(pixel_y_in_car1),
											.keycode(keycode_s1),                            
											.yellowcar_Y_default(yellowcar1_Y_default),
											.yellowcar_Y_Min(yellowcar1_Y_Min),              
											.yellowcar_Y_Max(yellowcar1_Y_Max),           
											.yellowcar_XX_Pos(),                          
											.yellowcar_YY_Pos(yellowcar1_Y_Pos)            
					);
					
	
	yellow_car my_yellow_car2( .*,.is_car(is_car2),
											.pixel_x_in_car(pixel_x_in_car2),
											.pixel_y_in_car(pixel_y_in_car2),
											.keycode(keycode_s2),
											.yellowcar_Y_default(yellowcar2_Y_default),
											.yellowcar_Y_Min(yellowcar2_Y_Min),
											.yellowcar_Y_Max(yellowcar2_Y_Max),
											.yellowcar_XX_Pos(),
											.yellowcar_YY_Pos(yellowcar2_Y_Pos)
					);
					
	yellow_car my_yellow_car3( .*,.is_car(is_car3),
											.pixel_x_in_car(pixel_x_in_car3),
											.pixel_y_in_car(pixel_y_in_car3),
											.keycode(keycode_s3),
											.yellowcar_Y_default(yellowcar3_Y_default),
											.yellowcar_Y_Min(yellowcar3_Y_Min),
											.yellowcar_Y_Max(yellowcar3_Y_Max),
											.yellowcar_XX_Pos(),
											.yellowcar_YY_Pos(yellowcar3_Y_Pos)
					);
	
	
	lane_control my_lane_control(.*,.car1_pos_max(yellowcar1_Y_Max),
											  .car2_pos_max(yellowcar2_Y_Max),
											  .car3_pos_max(yellowcar3_Y_Max),
											  .car1_pos(yellowcar1_Y_Pos),
											  .car2_pos(yellowcar2_Y_Pos),
											  .car3_pos(yellowcar3_Y_Pos),
											  .keycode_of_s(keycode),
											  .random_number(rand_a)
				);
	
	
	 
	 always_comb
	 begin
		
		
		if(  is_car1 || is_car2 || is_car3 )
			is_car = 1'b1;
		else
			is_car = 1'b0;
			
			
			
			pixel_x_in_car = pixel_x_in_car1;
			pixel_y_in_car = pixel_y_in_car1;
		
		if ( is_car1 )
		begin
			pixel_x_in_car = pixel_x_in_car1;
			pixel_y_in_car = pixel_y_in_car1;
		end
		
		
		if ( is_car2 )
		begin
			pixel_x_in_car = pixel_x_in_car2;
			pixel_y_in_car = pixel_y_in_car2;
		end
		
		
		if ( is_car3 )
		begin
			pixel_x_in_car = pixel_x_in_car3;
			pixel_y_in_car = pixel_y_in_car3;
		end
		
		
		end
	
	



endmodule
