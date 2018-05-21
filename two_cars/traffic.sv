/*

Description: Thel collection of 12 yellow cars which approach from top of the
screen randomly. 
Purpose: To store position of all 12 yellow cars and tell if a pixel belongs to one
 of the yellow cars. It also gives the offset sprite coordinate for each yellow
car.




*/



module traffic (	input  logic   	   Clk,                
													Reset,              
													frame_clk,          
						input  logic  [9:0]  DrawX, DrawY,
						output logic  			is_car,             // Whether current pixel (DrawX, DrawY) belongs to ball or background
						output logic  [9:0]  pixel_x_in_car, pixel_y_in_car,
					   input  logic  [7:0]  keycode,
						input  logic  [9:0]  car_step_size_x,
						input  logic  [9:0]  car_step_size_y,
						input integer speed,
						input	logic [9:0] redcar_XX_Pos,redcar_YY_Pos,
						input logic [9:0] bluecar_XX_Pos,bluecar_YY_Pos
						);
						
						

						logic is_car1,is_car2,is_car3,is_car4,is_car5,is_car6,is_car7,is_car8;
						
						logic [9:0]  pixel_x_in_car1,pixel_y_in_car1;
						logic [9:0]  pixel_x_in_car2,pixel_y_in_car2;
						logic [9:0]  pixel_x_in_car3,pixel_y_in_car3;
						logic [9:0]  pixel_x_in_car4,pixel_y_in_car4;
						logic [9:0]  pixel_x_in_car5,pixel_y_in_car5;
						logic [9:0]  pixel_x_in_car6,pixel_y_in_car6;
						logic [9:0]  pixel_x_in_car7,pixel_y_in_car7;
						logic [9:0]  pixel_x_in_car8,pixel_y_in_car8;
				
	integer yellowcar1_X_default ;
	integer yellowcar2_X_default ;
	integer yellowcar3_X_default ;
	integer yellowcar4_X_default ;
	integer yellowcar5_X_default ;
	integer yellowcar6_X_default ;
	integer yellowcar7_X_default ;
	integer yellowcar8_X_default ;
	
	integer yellowcar1_Y_default;
	integer yellowcar2_Y_default;
	integer yellowcar3_Y_default;
	
	integer yellowcar_X_Min ; 
	integer yellowcar_X_Max ; 
	
	integer yellowcar1_Y_Min ;
	integer yellowcar2_Y_Min ;
	integer yellowcar3_Y_Min ;
	
	integer yellowcar1_Y_Max ;
	integer yellowcar2_Y_Max ;
	integer yellowcar3_Y_Max ;
	
	assign yellowcar1_X_default =  (10'd59);
//	assign yellowcar2_X_default =  (10'd122);
	assign yellowcar2_X_default =  (10'd185);
//	assign yellowcar4_X_default =  (10'd248);
	assign yellowcar3_X_default =  (10'd311);
//	assign yellowcar6_X_default =  (10'd374);
	assign yellowcar4_X_default =  (10'd437);
//	assign yellowcar8_X_default =  (10'd500);
	
	assign yellowcar1_Y_default =  (-10'd400);    //   (10'd0);     
	assign yellowcar2_Y_default =  (-10'd250);    //   (10'd50);    
	assign yellowcar3_Y_default =  (-10'd100);    //   (10'd100);   
	
	assign yellowcar_X_Min  	= 			(10'd0);   
	assign yellowcar_X_Max  	= 			(10'd639); 
	
   assign yellowcar1_Y_Min 		=	(-10'd400);   //	  (10'd0);     
	assign yellowcar2_Y_Min 		=	(-10'd250);   //   (10'd50);      
	assign yellowcar3_Y_Min 		=	(-10'd100);   //   (10'd100);     
	
	assign yellowcar1_Y_Max 		=   (10'd579);  	//  (10'd200);  	  
	assign yellowcar2_Y_Max 		=   (10'd729);	 	//   (10'd250);  	  
	assign yellowcar3_Y_Max 		=   (10'd879);     //  (10'd300);    
	
	
	logic [31:0] seed_a,seed_b,seed_c,seed_d;
	
	assign seed_a = 32'hFEFEABCD;
	assign seed_b = 32'hFEFE8989;
	assign seed_c = 32'h4040ABCD;
	assign seed_d = 32'h7070ABCD;
	
	always_comb
	 begin
		
		
		if(  is_car1 || is_car2 || is_car3 || is_car4 )
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
		
		if ( is_car4 )
		begin
			pixel_x_in_car = pixel_x_in_car4;
			pixel_y_in_car = pixel_y_in_car4;
		end
		
		
		
	end

		
	

						lane my_lane1(.*,.is_car(is_car1),
						                 .pixel_x_in_car(pixel_x_in_car1),
						                 .pixel_y_in_car(pixel_y_in_car1),
											  .keycode(keycode),                 
											  .yellowcar_XX_default(yellowcar1_X_default),
											  
											  .yellowcar1_Y_default(yellowcar1_Y_default),
											  .yellowcar2_Y_default(yellowcar2_Y_default),
											  .yellowcar3_Y_default(yellowcar3_Y_default),
											  
											  .yellowcar1_Y_Min(yellowcar1_Y_Min),
											  .yellowcar2_Y_Min(yellowcar2_Y_Min),
											  .yellowcar3_Y_Min(yellowcar3_Y_Min),
											  
											  
											  .yellowcar1_Y_Max(yellowcar1_Y_Max),
											  .yellowcar2_Y_Max(yellowcar2_Y_Max),
											  .yellowcar3_Y_Max(yellowcar3_Y_Max),
											  .seed(seed_a)

											  
								);

		
						lane my_lane2(.*,.is_car(is_car2),
						                 .pixel_x_in_car(pixel_x_in_car2),
						                 .pixel_y_in_car(pixel_y_in_car2),
											  .keycode(keycode),                 
											  .yellowcar_XX_default(yellowcar2_X_default),
											  
											  .yellowcar1_Y_default(yellowcar1_Y_default),
											  .yellowcar2_Y_default(yellowcar2_Y_default),
											  .yellowcar3_Y_default(yellowcar3_Y_default),
											  
											  .yellowcar1_Y_Min(yellowcar1_Y_Min),
											  .yellowcar2_Y_Min(yellowcar2_Y_Min),
											  .yellowcar3_Y_Min(yellowcar3_Y_Min),
											  
											  
											  .yellowcar1_Y_Max(yellowcar1_Y_Max),
											  .yellowcar2_Y_Max(yellowcar2_Y_Max),
											  .yellowcar3_Y_Max(yellowcar3_Y_Max),
											  .seed(seed_b)
								);
					
						
						lane my_lane3(.*,.is_car(is_car3),
						                 .pixel_x_in_car(pixel_x_in_car3),
						                 .pixel_y_in_car(pixel_y_in_car3),
											  .keycode(keycode),                 
											  .yellowcar_XX_default(yellowcar3_X_default),
											  
											  .yellowcar1_Y_default(yellowcar1_Y_default),
											  .yellowcar2_Y_default(yellowcar2_Y_default),
											  .yellowcar3_Y_default(yellowcar3_Y_default),
											  
											  .yellowcar1_Y_Min(yellowcar1_Y_Min),
											  .yellowcar2_Y_Min(yellowcar2_Y_Min),
											  .yellowcar3_Y_Min(yellowcar3_Y_Min),
											  
											  
											  .yellowcar1_Y_Max(yellowcar1_Y_Max),
											  .yellowcar2_Y_Max(yellowcar2_Y_Max),
											  .yellowcar3_Y_Max(yellowcar3_Y_Max),
											  .seed(seed_c)
											
								);
								
							
						lane my_lane4(.*,.is_car(is_car4),
						                 .pixel_x_in_car(pixel_x_in_car4),
						                 .pixel_y_in_car(pixel_y_in_car4),
											  .keycode(keycode),                 
											  .yellowcar_XX_default(yellowcar4_X_default),
											  
											  .yellowcar1_Y_default(yellowcar1_Y_default),
											  .yellowcar2_Y_default(yellowcar2_Y_default),
											  .yellowcar3_Y_default(yellowcar3_Y_default),
											  
											  .yellowcar1_Y_Min(yellowcar1_Y_Min),
											  .yellowcar2_Y_Min(yellowcar2_Y_Min),
											  .yellowcar3_Y_Min(yellowcar3_Y_Min),
											  
											  
											  .yellowcar1_Y_Max(yellowcar1_Y_Max),
											  .yellowcar2_Y_Max(yellowcar2_Y_Max),
											  .yellowcar3_Y_Max(yellowcar3_Y_Max),
											  .seed(seed_d)
											  
								);
								
					
		
endmodule
