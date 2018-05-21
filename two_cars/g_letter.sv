/*********************************



g_letter sprite module

**********************************/

module  g_letter ( input  logic   	   Clk,                // 100 MHz clock
													Reset,              // Active-high reset signal
													frame_clk,          // The clock indicating a new frame (~60Hz)
						input  logic  [9:0]  DrawX, DrawY,       // Current pixel coordinates to be drawn on the monitor
						output logic  			is_g,             // Whether current pixel (DrawX, DrawY) belongs to ball or background
						output logic  [9:0]  pixel_x_in_g_letter, pixel_y_in_g_letter //relative to the car's top left pixel which is (0,0)
					);
	
	 parameter [9:0] g_letter_X_default = 10'd208;  // Center position on the X axis
    parameter [9:0] g_letter_Y_default = 10'd35;  // Center position on the Y axis
	 	
	 parameter [9:0] g_letter_size_X = 10'd74;        
	 parameter [9:0] g_letter_size_Y = 10'd99; 
	 
 
    logic [9:0] g_letter_X_Pos, g_letter_Y_Pos;
    logic [9:0] g_letter_X_Pos_in, g_letter_Y_Pos_in;
	 
	 
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
            g_letter_X_Pos <= g_letter_X_default;
            g_letter_Y_Pos <= g_letter_Y_default;
				

        end
        else
        begin
            g_letter_X_Pos <= g_letter_X_Pos_in;
            g_letter_Y_Pos <= g_letter_Y_Pos_in;
			
        end


    end
    //////// Do not modify the always_ff blocks. ////////
    
    // You need to modify always_comb block.
    always_comb
    begin
        // By default, keep motion and position unchanged
        g_letter_X_Pos_in = g_letter_X_Pos;
        g_letter_Y_Pos_in = g_letter_Y_Pos;

    end
    
	 logic temp1,temp2;
	 
	 
	 always_comb
	 begin
		
		temp1 = (DrawX >= g_letter_X_Pos && DrawX <= g_letter_X_Pos + g_letter_size_X)
			  && (DrawY >= g_letter_Y_Pos && DrawY <= g_letter_Y_Pos + g_letter_size_Y);

	 if(  temp1 )
	 begin
			is_g = 1'b1;
	 end
	
	 else
	 begin
			is_g = 1'b0;
	 end
	 
		pixel_x_in_g_letter = DrawX - g_letter_X_Pos;
		pixel_y_in_g_letter = DrawY - g_letter_Y_Pos;

    end
	
	 
	 
endmodule