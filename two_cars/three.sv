/*********************************

three digit sprite module

**********************************/

module  three ( input  logic   	   Clk,                // 100 MHz clock
													Reset,              // Active-high reset signal
													frame_clk,          // The clock indicating a new frame (~60Hz)
						input  logic  [9:0]  DrawX, DrawY,       // Current pixel coordinates to be drawn on the monitor
						output logic  			is_three,             // Whether current pixel (DrawX, DrawY) belongs to ball or background
						output logic  [9:0]  pixel_x_in_three, pixel_y_in_three //relative to the car's top left pixel which is (0,0)
					);
	
	 parameter [9:0] three1_X_default = 10'd208;  // Center position on the X axis
    parameter [9:0] three1_Y_default = 10'd35;  // Center position on the Y axis
	 
	 parameter [9:0] three2_X_default = 10'd347;  // Center position on the X axis
    parameter [9:0] three2_Y_default = 10'd35;  // Center position on the Y axis
		
	 parameter [9:0] three_size_X = 10'd74;        
	 parameter [9:0] three_size_Y = 10'd99; 
	 
 
    logic [9:0] three1_X_Pos, three1_Y_Pos;
    logic [9:0] three1_X_Pos_in, three1_Y_Pos_in;
	 
	 logic [9:0] three2_X_Pos, three2_Y_Pos;
    logic [9:0] three2_X_Pos_in, three2_Y_Pos_in;

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
            three1_X_Pos <= three1_X_default;
            three1_Y_Pos <= three1_Y_default;
				
				
            three2_X_Pos <= three2_X_default;
            three2_Y_Pos <= three2_Y_default;
        end
        else
        begin
            three1_X_Pos <= three1_X_Pos_in;
            three1_Y_Pos <= three1_Y_Pos_in;
				
            three2_X_Pos <= three2_X_Pos_in;
            three2_Y_Pos <= three2_Y_Pos_in;
        end


    end
    //////// Do not modify the always_ff blocks. ////////
    
    // You need to modify always_comb block.
    always_comb
    begin
        // By default, keep motion and position unchanged
        three1_X_Pos_in = three1_X_Pos;
        three1_Y_Pos_in = three1_Y_Pos;
		  
		  three2_X_Pos_in = three2_X_Pos;
        three2_Y_Pos_in = three2_Y_Pos;
 
  
    end
    
	 logic temp1,temp2;
	 
	 
	 always_comb
	 begin
		
		temp1 = (DrawX >= three1_X_Pos && DrawX <= three1_X_Pos + three_size_X)
			  && (DrawY >= three1_Y_Pos && DrawY <= three1_Y_Pos + three_size_Y);
			  
		temp2 = (DrawX >= three2_X_Pos && DrawX <= three2_X_Pos + three_size_X)
			  && (DrawY >= three2_Y_Pos && DrawY <= three2_Y_Pos + three_size_Y);
		
	 if(  temp1 || temp2 )
	 begin
			is_three = 1'b1;
	 end
	
	 else
	 begin
			is_three = 1'b0;
	 end
	 
			
		pixel_x_in_three = DrawX - three1_X_Pos;
		pixel_y_in_three = DrawY - three1_Y_Pos;
		
		if ( temp1 )
		begin
			pixel_x_in_three = DrawX - three1_X_Pos;
			pixel_y_in_three = DrawY - three1_Y_Pos;
		end
		
		if ( temp2 )
		begin
			pixel_x_in_three = DrawX - three2_X_Pos;
			pixel_y_in_three = DrawY - three2_Y_Pos;
		end
		
		
    end
	
	 
	 
endmodule
