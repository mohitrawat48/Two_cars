/*

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


*/






module  yellow_car ( input  logic   	Clk,                // 100 MHz clock
													Reset,              // Active-high reset signal
													frame_clk,          // The clock indicating a new frame (~60Hz)
						input  logic  [9:0]  DrawX, DrawY,       // Current pixel coordinates to be drawn on the monitor
						output logic  			is_car,             // Whether current pixel (DrawX, DrawY) belongs to ball or background
						output logic  [9:0]  pixel_x_in_car, pixel_y_in_car, //relative to the car's top left pixel which is (0,0)
						input  logic  [7:0]  keycode,
						input  logic  [9:0]  car_step_size_x,
						input  logic  [9:0]  car_step_size_y,
						input integer speed,
						
						input integer yellowcar_X_default, 
						input integer yellowcar_Y_default, 
						input integer yellowcar_X_Min, 		
						input integer yellowcar_X_Max, 		
						input integer yellowcar_Y_Min,		
						input integer yellowcar_Y_Max,		
				
						output integer yellowcar_XX_Pos,yellowcar_YY_Pos
					);
	


	 parameter integer yellowcar_size_X 	= 10'd49;        
	 parameter integer yellowcar_size_Y 	= 10'd99; 
	           
	 parameter [7:0] key_w = 8'h1A;
	 parameter [7:0] key_s = 8'h16;
	 parameter [7:0] key_d = 8'h07;
	 parameter [7:0] key_a = 8'h04;
	    
    integer  yellowcar_X_Pos, yellowcar_Y_Pos;
    integer  yellowcar_X_Pos_in, yellowcar_Y_Pos_in ;
	 
	 
	 assign yellowcar_XX_Pos = yellowcar_X_Pos;
	 assign yellowcar_YY_Pos = yellowcar_Y_Pos;
	 
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
            yellowcar_X_Pos <= yellowcar_X_default;
            yellowcar_Y_Pos <= yellowcar_Y_default;
				counter <= 0;
        end
        else
        begin
            yellowcar_X_Pos <= yellowcar_X_Pos_in;
            yellowcar_Y_Pos <= yellowcar_Y_Pos_in;
				counter <= counter_in;
        end
		  		
    end
    //////// Do not modify the always_ff blocks. ////////
    
    // You need to modify always_comb block.
    always_comb
    begin
        // By default, keep motion and position unchanged
        yellowcar_X_Pos_in = yellowcar_X_Pos;
        yellowcar_Y_Pos_in = yellowcar_Y_Pos;
		  counter_in = counter; 
			
        // Update position and motion only at rising edge of frame clock
		  if (frame_clk_rising_edge)
		  begin
			counter_in = counter + 1;
		  end
        if (counter == count )
        begin
		  
				counter_in = 0;
            
				if( yellowcar_X_Pos + yellowcar_size_X > yellowcar_X_Max ) 
						yellowcar_X_Pos_in = yellowcar_X_Max - yellowcar_size_X;
					
				if( yellowcar_X_Pos < yellowcar_X_Min ) 
						yellowcar_X_Pos_in = yellowcar_X_Min ;
				
				if( yellowcar_Y_Pos < yellowcar_Y_Min ) 
						yellowcar_Y_Pos_in =  yellowcar_Y_Max - yellowcar_size_Y;
						
				if( yellowcar_Y_Pos + yellowcar_size_Y > yellowcar_Y_Max )
				begin
						yellowcar_Y_Pos_in =  yellowcar_Y_Min ;
						yellowcar_X_Pos_in = yellowcar_X_default;
				end
				// TODO: Add other boundary detections and handle keypress here.
				
				
				if (keycode  == key_w && (! (yellowcar_Y_Pos < yellowcar_Y_Min) ) )
					yellowcar_Y_Pos_in = yellowcar_Y_Pos - car_step_size_y;				
				
				if (keycode  == key_s && ( !(yellowcar_Y_Pos + yellowcar_size_Y > yellowcar_Y_Max) ) )
					yellowcar_Y_Pos_in = yellowcar_Y_Pos + car_step_size_y;
					
				if (keycode  == key_d &&  !(yellowcar_X_Pos + yellowcar_size_X > yellowcar_X_Max) )
					yellowcar_X_Pos_in = yellowcar_X_Pos + car_step_size_x;
						
				if (keycode  == key_a && !(yellowcar_X_Pos < yellowcar_X_Min) )
					yellowcar_X_Pos_in = yellowcar_X_Pos - car_step_size_x;
					
        
        end
    end
    
	 logic temp1;
	 logic temp2;
	 
	 always_comb
	 begin
		
		
		temp1 = (XX >= yellowcar_X_Pos && XX <= yellowcar_X_Pos + yellowcar_size_X);
		temp2 = (YY >= yellowcar_Y_Pos && YY <= yellowcar_Y_Pos + yellowcar_size_Y);
		
		if(  temp1 && temp2  )
			is_car = 1'b1;
		else
			is_car = 1'b0;
   
		pixel_x_in_car <= XX - yellowcar_X_Pos;
		pixel_y_in_car <= YY - yellowcar_Y_Pos;
	 
	 end
	
			  
	
	 
	 
endmodule
