/*********************************

Based off ball.sv from lab 8
Player1 controls red car
**********************************/

module  o_letter ( input  logic   	   Clk,                // 100 MHz clock
													Reset,              // Active-high reset signal
													frame_clk,          // The clock indicating a new frame (~60Hz)
						input  logic  [9:0]  DrawX, DrawY,       // Current pixel coordinates to be drawn on the monitor
						output logic  			is_o,             // Whether current pixel (DrawX, DrawY) belongs to ball or background
						output logic  [9:0]  pixel_x_in_o_letter, pixel_y_in_o_letter //relative to the car's top left pixel which is (0,0)
					);
	
	 parameter [9:0] o_letter_X_default = 10'd347;  // Center position on the X axis
    parameter [9:0] o_letter_Y_default = 10'd35;  // Center position on the Y axis
	 	
	 parameter [9:0] o_letter_size_X = 10'd74;        
	 parameter [9:0] o_letter_size_Y = 10'd99; 
	 
 
    logic [9:0] o_letter_X_Pos, o_letter_Y_Pos;
    logic [9:0] o_letter_X_Pos_in, o_letter_Y_Pos_in;
	 
	 
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
            o_letter_X_Pos <= o_letter_X_default;
            o_letter_Y_Pos <= o_letter_Y_default;
				

        end
        else
        begin
            o_letter_X_Pos <= o_letter_X_Pos_in;
            o_letter_Y_Pos <= o_letter_Y_Pos_in;
			
        end


    end
    //////// Do not modify the always_ff blocks. ////////
    
    // You need to modify always_comb block.
    always_comb
    begin
        // By default, keep motion and position unchanged
        o_letter_X_Pos_in = o_letter_X_Pos;
        o_letter_Y_Pos_in = o_letter_Y_Pos;

    end
    
	 logic temp1,temp2;
	 
	 
	 always_comb
	 begin
		
		temp1 = (DrawX >= o_letter_X_Pos && DrawX <= o_letter_X_Pos + o_letter_size_X)
			  && (DrawY >= o_letter_Y_Pos && DrawY <= o_letter_Y_Pos + o_letter_size_Y);

	 if(  temp1 )
	 begin
			is_o = 1'b1;
	 end
	
	 else
	 begin
			is_o = 1'b0;
	 end
	 
		pixel_x_in_o_letter = DrawX - o_letter_X_Pos;
		pixel_y_in_o_letter = DrawY - o_letter_Y_Pos;

    end
	
	 
	 
endmodule
