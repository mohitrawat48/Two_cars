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

module  blue_car ( input  logic   	   Clk,                // 100 MHz clock
													Reset,              // Active-high reset signal
													frame_clk,          // The clock indicating a new frame (~60Hz)
						input  logic  [9:0]  DrawX, DrawY,       // Current pixel coordinates to be drawn on the monitor
						output logic  			is_car,             // Whether current pixel (DrawX, DrawY) belongs to ball or background
						output logic  [9:0]  pixel_x_in_car, pixel_y_in_car, //relative to the car's top left pixel which is (0,0)
						input  logic  [7:0]  keycode,
						input  logic  [9:0]  car_step_size_x,
						input  logic  [9:0]  car_step_size_y,
						input integer speed,
						
						output logic [9:0] bluecar_XX_Pos,bluecar_YY_Pos
					);
	
	 parameter integer bluecar_X_default = 10'd311;  // Center position on the X axis
    parameter integer bluecar_Y_default = 10'd380;  // Center position on the Y axis
    parameter integer bluecar_X_Min = 10'd59;       // Leftmost point on the X axis
    parameter integer bluecar_X_Max = 10'd545;     // Rightmost point on the X axis
    parameter integer bluecar_Y_Min = 10'd0;       // Topmost point on the Y axis
    parameter integer bluecar_Y_Max = 10'd479;     // Bottommost point on the Y axis

	 parameter integer bluecar_size_X = 10'd44;        
	 parameter integer bluecar_size_Y = 10'd99; 
	           
	 parameter [7:0] key_8 = 8'h60;
	 parameter [7:0] key_5 = 8'h5D;
	 parameter [7:0] key_6 = 8'h5E;
	 parameter [7:0] key_4 = 8'h5C;
	    
    integer  bluecar_X_Pos, bluecar_Y_Pos;
    integer  bluecar_X_Pos_in, bluecar_Y_Pos_in ;
	 
	 
	 assign bluecar_XX_Pos = bluecar_X_Pos;
	 assign bluecar_YY_Pos = bluecar_Y_Pos;
	 
	 integer XX;
	 integer YY;
	 
	 assign XX = DrawX;
    assign YY = DrawY;
	 
	 integer counter,counter_in;
	 integer count ;
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
            bluecar_X_Pos <= bluecar_X_default;
            bluecar_Y_Pos <= bluecar_Y_default;
				counter <= 0;
        end
        else
        begin
            bluecar_X_Pos <= bluecar_X_Pos_in;
            bluecar_Y_Pos <= bluecar_Y_Pos_in;
				counter <= counter_in;
        end
		  		
    end
    //////// Do not modify the always_ff blocks. ////////
    
    // You need to modify always_comb block.
    always_comb
    begin
        // By default, keep motion and position unchanged
        bluecar_X_Pos_in = bluecar_X_Pos;
        bluecar_Y_Pos_in = bluecar_Y_Pos;
 counter_in = counter; 
			
        // Update position and motion only at rising edge of frame clock
		  if (frame_clk_rising_edge)
		  begin
			counter_in = counter + 1;
		  end
        if (counter == count )
        begin
		  
				counter_in = 0;
            
				if( bluecar_X_Pos + bluecar_size_X > bluecar_X_Max ) 
						bluecar_X_Pos_in = bluecar_X_Max - bluecar_size_X;
					
				if( bluecar_X_Pos < bluecar_X_Min ) 
						bluecar_X_Pos_in = bluecar_X_Min ;
				
				if( bluecar_Y_Pos < bluecar_Y_Min ) 
						bluecar_Y_Pos_in = bluecar_Y_Min ;
						
				if( bluecar_Y_Pos + bluecar_size_Y > bluecar_Y_Max ) 
						bluecar_Y_Pos_in = bluecar_Y_Max - bluecar_size_Y;				
				
				// TODO: Add other boundary detections and handle keypress here.
				
				
				if (keycode  == key_8 && (! (bluecar_Y_Pos < bluecar_Y_Min) ) )
					bluecar_Y_Pos_in = bluecar_Y_Pos - car_step_size_y;				
				
				if (keycode  == key_5 && ( !(bluecar_Y_Pos + bluecar_size_Y > bluecar_Y_Max) ) )
					bluecar_Y_Pos_in = bluecar_Y_Pos + car_step_size_y;
					
				if (keycode  == key_6 &&  !(bluecar_X_Pos + bluecar_size_X > bluecar_X_Max) )
					bluecar_X_Pos_in = bluecar_X_Pos + car_step_size_x;
						
				if (keycode  == key_4 && !(bluecar_X_Pos < bluecar_X_Min) )
					bluecar_X_Pos_in = bluecar_X_Pos - car_step_size_x;
					
        
        end
    end
    
	 logic temp1;
	 logic temp2;
	 
	 always_comb
	 begin
		
		
		temp1 = (XX >= bluecar_X_Pos && XX <= bluecar_X_Pos + bluecar_size_X);
		temp2 = (YY >= bluecar_Y_Pos && YY <= bluecar_Y_Pos + bluecar_size_Y);
		
		if(  temp1 && temp2  )
			is_car = 1'b1;
		else
			is_car = 1'b0;
   
		pixel_x_in_car = XX - bluecar_X_Pos;
		pixel_y_in_car = YY - bluecar_Y_Pos;
	 
	 end
	
			  
	
	 
	 
endmodule
