/*********************************

Description: Takes in keycode and updates the position of this object and
 outputs two signals. One tells if pixel belongs to the car, the other
 gives the offset sprite coordinate.
 For example, offset sprite x coordinate = DrawX - sprite_X_position. 
 Where Draw X is current x coordinate to be drawn and sprite_X_position is the current X position of the sprite.
 
Purpose: Updates the position of the car at a desired frame rate. We update the
 	      position after every 5 frames so that the car shifts only by one unit
      when the user mechanically presses a key . If we update the position
      at every frame then car will move too quick because at every frame
      the car will get shifted.


**********************************/

module  red_car ( input  logic   	   Clk,                // 100 MHz clock
													Reset,              // Active-high reset signal
													frame_clk,          // The clock indicating a new frame (~60Hz)
						input  logic  [9:0]  DrawX, DrawY,       // Current pixel coordinates to be drawn on the monitor
						output logic  			is_car,             // Whether current pixel (DrawX, DrawY) belongs to ball or background
						output logic  [9:0]  pixel_x_in_car, pixel_y_in_car, //relative to the car's top left pixel which is (0,0)
						input  logic  [7:0]  keycode,
						input  logic  [9:0]  car_step_size_x,
						input  logic  [9:0]  car_step_size_y,
						input integer speed,
						
						output logic [9:0] redcar_XX_Pos,redcar_YY_Pos
					);
	
	 parameter integer  redcar_X_default = 10'd248;  // Center position on the X axis
    parameter integer  redcar_Y_default = 10'd380;  // Center position on the Y axis
    parameter integer  redcar_X_Min = 10'd59;       // Leftmost point on the X axis
    parameter integer  redcar_X_Max = 10'd545;     // Rightmost point on the X axis
    parameter integer  redcar_Y_Min = 10'd0;       // Topmost point on the Y axis
    parameter integer  redcar_Y_Max = 10'd479;     // Bottommost point on the Y axis

	 parameter integer  redcar_size_X = 10'd44;        
	 parameter integer  redcar_size_Y = 10'd99; 
	 
	 parameter [7:0] key_w = 8'h1A;
	 parameter [7:0] key_s = 8'h16;
	 parameter [7:0] key_d = 8'h07;
	 parameter [7:0] key_a = 8'h04;
	    
    integer  redcar_X_Pos, redcar_Y_Pos;
    integer  redcar_X_Pos_in, redcar_Y_Pos_in;
	 
	 assign redcar_XX_Pos = redcar_X_Pos;
	 assign redcar_YY_Pos = redcar_Y_Pos;
	 
	 integer XX;
	 integer YY;
	 
	 assign XX = DrawX;
    assign YY = DrawY;
	 
	 integer counter,counter_in;
	 integer count;
	 assign count = speed;
    
    //////// Do not modify the always_ff blocks. ////////
    // Detect rising edge of frame_clk
    logic frame_clk_delayed, frame_clk_rising_edge;
    always_ff @ (posedge Clk) begin
        frame_clk_delayed <= frame_clk;
        frame_clk_rising_edge <= (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
    end
    // Update registers
    always_ff @ (posedge Clk)
    begin
        if (Reset)
        begin
            redcar_X_Pos <= redcar_X_default;
            redcar_Y_Pos <= redcar_Y_default;
				counter <= 0;
        end
        else
        begin
            redcar_X_Pos <= redcar_X_Pos_in;
            redcar_Y_Pos <= redcar_Y_Pos_in;
				counter <= counter_in;
        end
		  		
    end
    //////// Do not modify the always_ff blocks. ////////
    
    // You need to modify always_comb block.
    always_comb
    begin
        // By default, keep motion and position unchanged
        redcar_X_Pos_in = redcar_X_Pos;
        redcar_Y_Pos_in = redcar_Y_Pos;
		  counter_in = counter; 
			
        // Update position and motion only at rising edge of frame clock
		  if (frame_clk_rising_edge)
		  begin
			counter_in = counter + 1;
		  end
        if (counter == count )
        begin
		  
				counter_in = 0;
            
				if( redcar_X_Pos + redcar_size_X > redcar_X_Max ) 
						redcar_X_Pos_in = redcar_X_Max - redcar_size_X;
					
				if( redcar_X_Pos < redcar_X_Min ) 
						redcar_X_Pos_in = redcar_X_Min ;
				
				if( redcar_Y_Pos < redcar_Y_Min ) 
						redcar_Y_Pos_in = redcar_Y_Min ;
						
				if( redcar_Y_Pos + redcar_size_Y > redcar_Y_Max ) 
						redcar_Y_Pos_in = redcar_Y_Max - redcar_size_Y;				
				
				// TODO: Add other boundary detections and handle keypress here.
				
				
				if (keycode  == key_w && (! (redcar_Y_Pos < redcar_Y_Min) ) )
					redcar_Y_Pos_in = redcar_Y_Pos - car_step_size_y;				
				
				if (keycode  == key_s && ( !(redcar_Y_Pos + redcar_size_Y > redcar_Y_Max) ) )
					redcar_Y_Pos_in = redcar_Y_Pos + car_step_size_y;
					
				if (keycode  == key_d &&  !(redcar_X_Pos + redcar_size_X > redcar_X_Max) )
					redcar_X_Pos_in = redcar_X_Pos + car_step_size_x;
						
				if (keycode  == key_a && !(redcar_X_Pos < redcar_X_Min) )
					redcar_X_Pos_in = redcar_X_Pos - car_step_size_x;
					
        
        end
    end
    
	 logic temp1;
	 logic temp2;
	 
	 always_comb
	 begin
		
		
		temp1 = (XX >= redcar_X_Pos && XX <= redcar_X_Pos + redcar_size_X);
		temp2 = (YY >= redcar_Y_Pos && YY <= redcar_Y_Pos + redcar_size_Y);
	 if(  temp1 && temp2  )
			is_car = 1'b1;
		else
			is_car = 1'b0;
   

		pixel_x_in_car = XX - redcar_X_Pos;
		pixel_y_in_car = YY - redcar_Y_Pos;
	 
		end
	
			  
	
	 
	 
endmodule
