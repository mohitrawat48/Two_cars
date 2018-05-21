/*********************************

one digit sprite module

**********************************/

module  one ( input  logic   	   Clk,                // 100 MHz clock
													Reset,              // Active-high reset signal
													frame_clk,          // The clock indicating a new frame (~60Hz)
						input  logic  [9:0]  DrawX, DrawY,       // Current pixel coordinates to be drawn on the monitor
						output logic  			is_one,             // Whether current pixel (DrawX, DrawY) belongs to ball or background
						output logic  [9:0]  pixel_x_in_one, pixel_y_in_one //relative to the car's top left pixel which is (0,0)
					);
	
	 parameter [9:0] one1_X_default = 10'd208;  // Center position on the X axis
    parameter [9:0] one1_Y_default = 10'd35;  // Center position on the Y axis
	 
	 parameter [9:0] one2_X_default = 10'd347;  // Center position on the X axis
    parameter [9:0] one2_Y_default = 10'd35;  // Center position on the Y axis
		
	 parameter [9:0] one_size_X = 10'd74;        
	 parameter [9:0] one_size_Y = 10'd99; 
	 
 
    logic [9:0] one1_X_Pos, one1_Y_Pos;
    logic [9:0] one1_X_Pos_in, one1_Y_Pos_in;
	 
	 logic [9:0] one2_X_Pos, one2_Y_Pos;
    logic [9:0] one2_X_Pos_in, one2_Y_Pos_in;

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
            one1_X_Pos <= one1_X_default;
            one1_Y_Pos <= one1_Y_default;
				
				
            one2_X_Pos <= one2_X_default;
            one2_Y_Pos <= one2_Y_default;
        end
        else
        begin
            one1_X_Pos <= one1_X_Pos_in;
            one1_Y_Pos <= one1_Y_Pos_in;
				
            one2_X_Pos <= one2_X_Pos_in;
            one2_Y_Pos <= one2_Y_Pos_in;
        end


    end
    //////// Do not modify the always_ff blocks. ////////
    
    // You need to modify always_comb block.
    always_comb
    begin
        // By default, keep motion and position unchanged
        one1_X_Pos_in = one1_X_Pos;
        one1_Y_Pos_in = one1_Y_Pos;
		  
		  one2_X_Pos_in = one2_X_Pos;
        one2_Y_Pos_in = one2_Y_Pos;
 
  
    end
    
	 logic temp1,temp2;
	 
	 
	 always_comb
	 begin
		
		temp1 = (DrawX >= one1_X_Pos && DrawX <= one1_X_Pos + one_size_X)
			  && (DrawY >= one1_Y_Pos && DrawY <= one1_Y_Pos + one_size_Y);
			  
		temp2 = (DrawX >= one2_X_Pos && DrawX <= one2_X_Pos + one_size_X)
			  && (DrawY >= one2_Y_Pos && DrawY <= one2_Y_Pos + one_size_Y);
		
	 if(  temp1 || temp2 )
	 begin
			is_one = 1'b1;
	 end
	
	 else
	 begin
			is_one = 1'b0;
	 end
	 
			
		pixel_x_in_one = DrawX - one1_X_Pos;
		pixel_y_in_one = DrawY - one1_Y_Pos;
		
		if ( temp1 )
		begin
			pixel_x_in_one = DrawX - one1_X_Pos;
			pixel_y_in_one = DrawY - one1_Y_Pos;
		end
		
		if ( temp2 )
		begin
			pixel_x_in_one = DrawX - one2_X_Pos;
			pixel_y_in_one = DrawY - one2_Y_Pos;
		end
		
		
    end
	
	 
	 
endmodule
