/*********************************

player 2 win sprite module

**********************************/

module  p2 ( input  logic   	   Clk,                // 100 MHz clock
													Reset,              // Active-high reset signal
													frame_clk,          // The clock indicating a new frame (~60Hz)
						input  logic  [9:0]  DrawX, DrawY,       // Current pixel coordinates to be drawn on the monitor
						output logic  			is_p2,             // Whether current pixel (DrawX, DrawY) belongs to ball or background
						output logic  [9:0]  pixel_x_in_p2, pixel_y_in_p2 //relative to the car's top left pixel which is (0,0)
					);
	
	 parameter [9:0] p2_X_default = 10'd0;  // Center position on the X axis
    parameter [9:0] p2_Y_default = 10'd150;  // Center position on the Y axis
	 	
	 parameter [9:0] p2_size_X = 10'd639;        
	 parameter [9:0] p2_size_Y = 10'd99; 
	 
 
    logic [9:0] p2_X_Pos, p2_Y_Pos;
    logic [9:0] p2_X_Pos_in, p2_Y_Pos_in;
	 
	 
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
            p2_X_Pos <= p2_X_default;
            p2_Y_Pos <= p2_Y_default;
				

        end
        else
        begin
            p2_X_Pos <= p2_X_Pos_in;
            p2_Y_Pos <= p2_Y_Pos_in;
			
        end


    end
    //////// Do not modify the always_ff blocks. ////////
    
    // You need to modify always_comb block.
    always_comb
    begin
        // By default, keep motion and position unchanged
        p2_X_Pos_in = p2_X_Pos;
        p2_Y_Pos_in = p2_Y_Pos;

    end
    
	 logic temp1,temp2;
	 
	 
	 always_comb
	 begin
		
		temp1 = (DrawX >= p2_X_Pos && DrawX <= p2_X_Pos + p2_size_X)
			  && (DrawY >= p2_Y_Pos && DrawY <= p2_Y_Pos + p2_size_Y);

	 if(  temp1 )
	 begin
			is_p2 = 1'b1;
	 end
	
	 else
	 begin
			is_p2 = 1'b0;
	 end
	 
		pixel_x_in_p2 = DrawX - p2_X_Pos;
		pixel_y_in_p2 = DrawY - p2_Y_Pos;

    end
	
	 
	 
endmodule
