/*********************************

module for startline 


**********************************/

module  startline ( input  logic   	   Clk,                // 100 MHz clock
													Reset,              // Active-high reset signal
													frame_clk,          // The clock indicating a new frame (~60Hz)
						input  logic  [9:0]  DrawX, DrawY,       // Current pixel coordinates to be drawn on the monitor
						output logic  			is_startline,             // Whether current pixel (DrawX, DrawY) belongs to ball or background
						output logic  [9:0]  pixel_x_in_startline, pixel_y_in_startline, //relative to the car's top left pixel which is (0,0)
						input  logic  [9:0]  step_size,
						input integer speed,
						input logic [7:0] keycode
					);
	
	 parameter [9:0] startline_X_default = 10'd59;  // Center position on the X axis
    parameter [9:0] startline_Y_default = 10'd255;  // Center position on the Y axis
		
	 parameter [9:0] startline_size_X = 10'd501;        
	 parameter [9:0] startline_size_Y = 10'd74; 
	 
 
    logic [9:0] startline_X_Pos, startline_Y_Pos;
    logic [9:0] startline_X_Pos_in, startline_Y_Pos_in;
	 
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
		  
				counter <= 0;
            startline_X_Pos <= startline_X_default;
            startline_Y_Pos <= startline_Y_default;
        end
        else
        begin
            startline_X_Pos <= startline_X_Pos_in;
            startline_Y_Pos <= startline_Y_Pos_in;
				counter <= counter_in;
        end


    end
    //////// Do not modify the always_ff blocks. ////////
    
    // You need to modify always_comb block.
    always_comb
    begin
        // By default, keep motion and position unchanged
        startline_X_Pos_in = startline_X_Pos;
        startline_Y_Pos_in = startline_Y_Pos;
 
       counter_in = counter; 
			
        // Update position and motion only at rising edge of frame clock
		  if (frame_clk_rising_edge)
		  begin
			counter_in = counter + 1;
		  end
        if (counter == count )
        begin
		  
				counter_in = 0;
         
				if( startline_Y_Pos <= 500)
				begin
					if (keycode  == 8'h16 )
						startline_Y_Pos_in = startline_Y_Pos + step_size;
				end
				
        end
    end
    
	 logic temp1;
	 logic temp2;
	 
	 always_comb
	 begin
		
		temp1 = (DrawX >= startline_X_Pos && DrawX <= startline_X_Pos + startline_size_X);
		temp2 = (DrawY >= startline_Y_Pos && DrawY <= startline_Y_Pos + startline_size_Y);
	 
	 if(  temp1 && temp2  )
	 begin
			is_startline = 1'b1;
	 end
	
	 else
	 begin
			is_startline = 1'b0;
	 end
			
	 //
	 pixel_x_in_startline = DrawX - startline_X_Pos;
	 pixel_y_in_startline = DrawY - startline_Y_Pos;
		
    end
	
	 
	 
endmodule
