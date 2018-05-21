/*********************************


stores position of 8 trees, Once a tree goes out of screen from below, then the position 
is reset at the top.




**********************************/

module  tree ( input  logic   	      Clk,                // 100 MHz clock
													Reset,              // Active-high reset signal
													frame_clk,          // The clock indicating a new frame (~60Hz)
						input  logic  [9:0]  DrawX, DrawY,       // Current pixel coordinates to be drawn on the monitor
						output logic  			is_tree,             // Whether current pixel (DrawX, DrawY) belongs to ball or background
						output logic  [9:0]  pixel_x_in_tree, pixel_y_in_tree, //relative to the tree's top left pixel which is (0,0)
						input  logic  [7:0]  keycode,
						input  logic  [9:0]  step_size,
						input integer speed

					);
	
	 parameter integer tree1_X_default = 10'd0;  // Center position on the X axis
    parameter integer tree1_Y_default = -10'd95;  // Center position on the Y axis
    
	 parameter integer tree2_X_default = 10'd0;  // Center position on the X axis
    parameter integer tree2_Y_default = 10'd35;  // Center position on the Y axis
    
	 parameter integer tree3_X_default = 10'd0;  // Center position on the X axis
    parameter integer tree3_Y_default = 10'd155;  // Center position on the Y axis
    
	 parameter integer tree4_X_default = 10'd0;  // Center position on the X axis
    parameter integer tree4_Y_default = 10'd275;  // Center position on the Y axis
    
	 parameter integer tree5_X_default = 10'd0;  // Center position on the X axis
    parameter integer tree5_Y_default = 10'd395;  // Center position on the Y axis
    
	 parameter integer tree6_X_default = 10'd569;  // Center position on the X axis
    parameter integer tree6_Y_default = -10'd95;  // Center position on the Y axis
    
	 parameter integer tree7_X_default = 10'd569;  // Center position on the X axis
    parameter integer tree7_Y_default = 10'd35;  // Center position on the Y axis
    
	 parameter integer tree8_X_default = 10'd569;  // Center position on the X axis
    parameter integer tree8_Y_default = 10'd155;  // Center position on the Y axis
	 
	 parameter integer tree9_X_default = 10'd569;  // Center position on the X axis
    parameter integer tree9_Y_default = 10'd275;  // Center position on the Y axis
	 
	 parameter integer tree10_X_default = 10'd569;  // Center position on the X axis
    parameter integer tree10_Y_default = 10'd395;  // Center position on the Y axis
    
	 
	 parameter integer tree_X_Min = 10'd0;       // Leftmost point on the X axis
    parameter integer tree_X_Max = 10'd639;     // Rightmost point on the X axis
    parameter integer tree_Y_Min = -10'd95;       // Topmost point on the Y axis
    parameter integer tree_Y_Max = 10'd565;     // Bottommost point on the Y axis

	 parameter integer tree_size_X = 10'd49;        
	 parameter integer tree_size_Y = 10'd49; 
	 
	 parameter [7:0] key_w = 8'h1A;
	 parameter [7:0] key_s = 8'h16;
	 parameter [7:0] key_d = 8'h07;
	 parameter [7:0] key_a = 8'h04;
	    
    integer tree1_X_Pos, tree1_Y_Pos;
    integer tree1_X_Pos_in, tree1_Y_Pos_in;
	 
	 integer tree2_X_Pos, tree2_Y_Pos;
    integer tree2_X_Pos_in, tree2_Y_Pos_in;
	 
	 integer tree3_X_Pos, tree3_Y_Pos;
    integer tree3_X_Pos_in, tree3_Y_Pos_in;
	 
	 integer tree4_X_Pos, tree4_Y_Pos;
    integer tree4_X_Pos_in, tree4_Y_Pos_in;
	 
	 integer tree5_X_Pos, tree5_Y_Pos;
    integer tree5_X_Pos_in, tree5_Y_Pos_in;
	 
	 integer tree6_X_Pos, tree6_Y_Pos;
    integer tree6_X_Pos_in, tree6_Y_Pos_in;
	 
	 integer tree7_X_Pos, tree7_Y_Pos;
    integer tree7_X_Pos_in, tree7_Y_Pos_in;
	 
	 integer tree8_X_Pos, tree8_Y_Pos;
    integer tree8_X_Pos_in, tree8_Y_Pos_in;
	 
	 integer tree9_X_Pos, tree9_Y_Pos;
    integer tree9_X_Pos_in, tree9_Y_Pos_in;
	 
	 integer tree10_X_Pos, tree10_Y_Pos;
    integer tree10_X_Pos_in, tree10_Y_Pos_in;
	 
	
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
		  
				counter <= 0;
				
            tree1_X_Pos <= tree1_X_default;
            tree1_Y_Pos <= tree1_Y_default;
				                   
				tree2_X_Pos <= tree2_X_default;
            tree2_Y_Pos <= tree2_Y_default;
				                   
				tree3_X_Pos <= tree3_X_default;
            tree3_Y_Pos <= tree3_Y_default;
				                   
				tree4_X_Pos <= tree4_X_default;
            tree4_Y_Pos <= tree4_Y_default;
				                   
				tree5_X_Pos <= tree5_X_default;
            tree5_Y_Pos <= tree5_Y_default;
				                   
				tree6_X_Pos <= tree6_X_default;
            tree6_Y_Pos <= tree6_Y_default;
				                   
				tree7_X_Pos <= tree7_X_default;
            tree7_Y_Pos <= tree7_Y_default;
				                   
				tree8_X_Pos <= tree8_X_default;
            tree8_Y_Pos <= tree8_Y_default;
				                   
				tree9_X_Pos <= tree9_X_default;
            tree9_Y_Pos <= tree9_Y_default;
				                   
				tree10_X_Pos <= tree10_X_default;
            tree10_Y_Pos <= tree10_Y_default;
				
		  end
        else
        begin
		  
				counter <= counter_in;
				
				tree1_X_Pos <= tree1_X_Pos_in;
				tree1_Y_Pos <= tree1_Y_Pos_in;
				               
				tree2_X_Pos <= tree2_X_Pos_in;
				tree2_Y_Pos <= tree2_Y_Pos_in;
				               
				tree3_X_Pos <= tree3_X_Pos_in;
				tree3_Y_Pos <= tree3_Y_Pos_in;
				               
				tree4_X_Pos <= tree4_X_Pos_in;
				tree4_Y_Pos <= tree4_Y_Pos_in;
				               
				tree5_X_Pos <= tree5_X_Pos_in;
				tree5_Y_Pos <= tree5_Y_Pos_in;
				               
				tree6_X_Pos <= tree6_X_Pos_in;
				tree6_Y_Pos <= tree6_Y_Pos_in;
				               
				tree7_X_Pos <= tree7_X_Pos_in;
				tree7_Y_Pos <= tree7_Y_Pos_in;
				               
				tree8_X_Pos <= tree8_X_Pos_in;
				tree8_Y_Pos <= tree8_Y_Pos_in;
				               
				tree9_X_Pos <= tree9_X_Pos_in;
				tree9_Y_Pos <= tree9_Y_Pos_in;
				               
				tree10_X_Pos <= tree10_X_Pos_in;
				tree10_Y_Pos <= tree10_Y_Pos_in;

        end
		  		
    end
    //////// Do not modify the always_ff blocks. ////////
    
    // You need to modify always_comb block.
    always_comb
    begin
        // By default, keep motion and position unchanged
        tree1_X_Pos_in   =   tree1_X_Pos  ;
		  tree1_Y_Pos_in   =   tree1_Y_Pos  ;
		                                   
		  tree2_X_Pos_in   =   tree2_X_Pos  ;
		  tree2_Y_Pos_in   =   tree2_Y_Pos  ;
		                                   
		  tree3_X_Pos_in   =   tree3_X_Pos  ;
		  tree3_Y_Pos_in   =   tree3_Y_Pos  ;
		                                   
		  tree4_X_Pos_in   =   tree4_X_Pos  ;
		  tree4_Y_Pos_in   =   tree4_Y_Pos  ;
		                                   
		  tree5_X_Pos_in   =   tree5_X_Pos  ;
		  tree5_Y_Pos_in   =   tree5_Y_Pos  ;
		                                   
		  tree6_X_Pos_in   =   tree6_X_Pos  ;
		  tree6_Y_Pos_in   =   tree6_Y_Pos  ;
		                                   
		  tree7_X_Pos_in   =   tree7_X_Pos  ;
		  tree7_Y_Pos_in   =   tree7_Y_Pos  ;
		                                   
		  tree8_X_Pos_in   =   tree8_X_Pos  ;
		  tree8_Y_Pos_in   =   tree8_Y_Pos  ;
		                                   
		  tree9_X_Pos_in   =   tree9_X_Pos  ;
		  tree9_Y_Pos_in   =   tree9_Y_Pos 	;
		                                   
		  tree10_X_Pos_in  =   tree10_X_Pos ;
		  tree10_Y_Pos_in  =   tree10_Y_Pos ;
		  
		  counter_in = counter; 
			
        // Update position and motion only at rising edge of frame clock
		  if (frame_clk_rising_edge)
		  begin
			counter_in = counter + 1;
		  end
		  
        if (counter == count )
        begin
		  
				counter_in = 0;
				
				if( tree1_X_Pos + tree_size_X > tree_X_Max ) 
						tree1_X_Pos_in = tree_X_Max - tree_size_X;
					
				if( tree1_X_Pos < tree_X_Min ) 
						tree1_X_Pos_in = tree_X_Min ;
				
				if( tree1_Y_Pos < tree_Y_Min ) 
						tree1_Y_Pos_in = tree_Y_Max - tree_size_Y ;
						
				if( tree1_Y_Pos + tree_size_Y > tree_Y_Max ) 
						tree1_Y_Pos_in = tree_Y_Min ;		
				
				////////////
				
				if( tree2_X_Pos + tree_size_X > tree_X_Max ) 
						tree2_X_Pos_in = tree_X_Max - tree_size_X;
					
				if( tree2_X_Pos < tree_X_Min ) 
						tree2_X_Pos_in = tree_X_Min ;
				
				if( tree2_Y_Pos < tree_Y_Min ) 
						tree2_Y_Pos_in = tree_Y_Max - tree_size_Y ;
						
				if( tree2_Y_Pos + tree_size_Y > tree_Y_Max ) 
						tree2_Y_Pos_in = tree_Y_Min;		
				
				////////////
				
				if( tree3_X_Pos + tree_size_X > tree_X_Max ) 
						tree3_X_Pos_in = tree_X_Max - tree_size_X;
					
				if( tree3_X_Pos < tree_X_Min ) 
						tree3_X_Pos_in = tree_X_Min ;
				
				if( tree3_Y_Pos < tree_Y_Min ) 
						tree3_Y_Pos_in = tree_Y_Max - tree_size_Y ;
						
				if( tree3_Y_Pos + tree_size_Y > tree_Y_Max ) 
						tree3_Y_Pos_in = tree_Y_Min;		
				
				////////////
				
				if( tree4_X_Pos + tree_size_X > tree_X_Max ) 
						tree4_X_Pos_in = tree_X_Max - tree_size_X;
					
				if( tree4_X_Pos < tree_X_Min ) 
						tree4_X_Pos_in = tree_X_Min ;
				
				if( tree4_Y_Pos < tree_Y_Min ) 
						tree4_Y_Pos_in = tree_Y_Max - tree_size_Y ;
						
				if( tree4_Y_Pos + tree_size_Y > tree_Y_Max ) 
						tree4_Y_Pos_in = tree_Y_Min;		
				
				////////////
				
				if( tree5_X_Pos + tree_size_X > tree_X_Max ) 
						tree5_X_Pos_in = tree_X_Max - tree_size_X;
					
				if( tree5_X_Pos < tree_X_Min ) 
						tree5_X_Pos_in = tree_X_Min ;
				
				if( tree5_Y_Pos < tree_Y_Min ) 
						tree5_Y_Pos_in = tree_Y_Max - tree_size_Y ;
						
				if( tree5_Y_Pos + tree_size_Y > tree_Y_Max ) 
						tree5_Y_Pos_in = tree_Y_Min;		
				
				////////////
				
				if( tree6_X_Pos + tree_size_X > tree_X_Max ) 
						tree6_X_Pos_in = tree_X_Max - tree_size_X;
					
				if( tree6_X_Pos < tree_X_Min ) 
						tree6_X_Pos_in = tree_X_Min ;
				
				if( tree6_Y_Pos < tree_Y_Min ) 
						tree6_Y_Pos_in = tree_Y_Max - tree_size_Y ;
						
				if( tree6_Y_Pos + tree_size_Y > tree_Y_Max ) 
						tree6_Y_Pos_in = tree_Y_Min;		
				
				////////////
				
				if( tree7_X_Pos + tree_size_X > tree_X_Max ) 
						tree7_X_Pos_in = tree_X_Max - tree_size_X;
					
				if( tree7_X_Pos < tree_X_Min ) 
						tree7_X_Pos_in = tree_X_Min ;
				
				if( tree7_Y_Pos < tree_Y_Min ) 
						tree7_Y_Pos_in = tree_Y_Max - tree_size_Y ;
						
				if( tree7_Y_Pos + tree_size_Y > tree_Y_Max ) 
						tree7_Y_Pos_in = tree_Y_Min;		
				
				////////////
				
				if( tree8_X_Pos + tree_size_X > tree_X_Max ) 
						tree8_X_Pos_in = tree_X_Max - tree_size_X;
					
				if( tree8_X_Pos < tree_X_Min ) 
						tree8_X_Pos_in = tree_X_Min ;
				
				if( tree8_Y_Pos < tree_Y_Min ) 
						tree8_Y_Pos_in = tree_Y_Max - tree_size_Y ;
						
				if( tree8_Y_Pos + tree_size_Y > tree_Y_Max ) 
						tree8_Y_Pos_in = tree_Y_Min;		
				
				////////////
				
				if( tree9_X_Pos + tree_size_X > tree_X_Max ) 
						tree9_X_Pos_in = tree_X_Max - tree_size_X;
					
				if( tree9_X_Pos < tree_X_Min ) 
						tree9_X_Pos_in = tree_X_Min ;
				
				if( tree9_Y_Pos < tree_Y_Min ) 
						tree9_Y_Pos_in = tree_Y_Max - tree_size_Y ;
						
				if( tree9_Y_Pos + tree_size_Y > tree_Y_Max ) 
						tree9_Y_Pos_in = tree_Y_Min;		
				
				////////////
				
				if( tree10_X_Pos + tree_size_X > tree_X_Max ) 
						tree10_X_Pos_in = tree_X_Max - tree_size_X;
					
				if( tree10_X_Pos < tree_X_Min ) 
						tree10_X_Pos_in = tree_X_Min ;
				
				if( tree10_Y_Pos < tree_Y_Min ) 
						tree10_Y_Pos_in = tree_Y_Max - tree_size_Y ;
						
				if( tree10_Y_Pos + tree_size_Y > tree_Y_Max ) 
						tree10_Y_Pos_in = tree_Y_Min;		
				
				////////////
				

		
				
				
				// TODO: Add other boundary detections and handle keypress here.
				
				
				if (keycode  == key_w && (! (tree1_Y_Pos < tree_Y_Min) ) )
					tree1_Y_Pos_in = tree1_Y_Pos - step_size;				
				
				if (keycode  == key_s && ( !(tree1_Y_Pos + tree_size_Y > tree_Y_Max) ) )
					tree1_Y_Pos_in = tree1_Y_Pos + step_size;
					
				if (keycode  == key_d &&  !(tree1_X_Pos + tree_size_X > tree_X_Max) )
					tree1_X_Pos_in = tree1_X_Pos + step_size;
						
				if (keycode  == key_a && !(tree1_X_Pos < tree_X_Min) )
					tree1_X_Pos_in = tree1_X_Pos - step_size;
					
				//////////////////////////	
				
				if (keycode  == key_w && (! (tree2_Y_Pos < tree_Y_Min) ) )
					tree2_Y_Pos_in = tree2_Y_Pos - step_size;				
				
				if (keycode  == key_s && ( !(tree2_Y_Pos + tree_size_Y > tree_Y_Max) ) )
					tree2_Y_Pos_in = tree2_Y_Pos + step_size;
					
				if (keycode  == key_d &&  !(tree2_X_Pos + tree_size_X > tree_X_Max) )
					tree2_X_Pos_in = tree2_X_Pos + step_size;
						
				if (keycode  == key_a && !(tree2_X_Pos < tree_X_Min) )
					tree2_X_Pos_in = tree2_X_Pos - step_size;
					
				//////////////////////////
				
				if (keycode  == key_w && (! (tree3_Y_Pos < tree_Y_Min) ) )
					tree3_Y_Pos_in = tree3_Y_Pos - step_size;				
				
				if (keycode  == key_s && ( !(tree3_Y_Pos + tree_size_Y > tree_Y_Max) ) )
					tree3_Y_Pos_in = tree3_Y_Pos + step_size;
					
				if (keycode  == key_d &&  !(tree3_X_Pos + tree_size_X > tree_X_Max) )
					tree3_X_Pos_in = tree3_X_Pos + step_size;
						
				if (keycode  == key_a && !(tree3_X_Pos < tree_X_Min) )
					tree3_X_Pos_in = tree3_X_Pos - step_size;
					
				//////////////////////////
				
				if (keycode  == key_w && (! (tree4_Y_Pos < tree_Y_Min) ) )
					tree4_Y_Pos_in = tree4_Y_Pos - step_size;				
				
				if (keycode  == key_s && ( !(tree4_Y_Pos + tree_size_Y > tree_Y_Max) ) )
					tree4_Y_Pos_in = tree4_Y_Pos + step_size;
					
				if (keycode  == key_d &&  !(tree4_X_Pos + tree_size_X > tree_X_Max) )
					tree4_X_Pos_in = tree4_X_Pos + step_size;
						
				if (keycode  == key_a && !(tree4_X_Pos < tree_X_Min) )
					tree4_X_Pos_in = tree4_X_Pos - step_size;
					
				//////////////////////////
				
				if (keycode  == key_w && (! (tree5_Y_Pos < tree_Y_Min) ) )
					tree5_Y_Pos_in = tree5_Y_Pos - step_size;				
				
				if (keycode  == key_s && ( !(tree5_Y_Pos + tree_size_Y > tree_Y_Max) ) )
					tree5_Y_Pos_in = tree5_Y_Pos + step_size;
					
				if (keycode  == key_d &&  !(tree5_X_Pos + tree_size_X > tree_X_Max) )
					tree5_X_Pos_in = tree5_X_Pos + step_size;
						
				if (keycode  == key_a && !(tree5_X_Pos < tree_X_Min) )
					tree5_X_Pos_in = tree5_X_Pos - step_size;
					
				//////////////////////////
				
				if (keycode  == key_w && (! (tree6_Y_Pos < tree_Y_Min) ) )
					tree6_Y_Pos_in = tree6_Y_Pos - step_size;				
				
				if (keycode  == key_s && ( !(tree6_Y_Pos + tree_size_Y > tree_Y_Max) ) )
					tree6_Y_Pos_in = tree6_Y_Pos + step_size;
					
				if (keycode  == key_d &&  !(tree6_X_Pos + tree_size_X > tree_X_Max) )
					tree6_X_Pos_in = tree6_X_Pos + step_size;
						
				if (keycode  == key_a && !(tree6_X_Pos < tree_X_Min) )
					tree6_X_Pos_in = tree6_X_Pos - step_size;
					
				//////////////////////////
				
				if (keycode  == key_w && (! (tree7_Y_Pos < tree_Y_Min) ) )
					tree7_Y_Pos_in = tree7_Y_Pos - step_size;				
				
				if (keycode  == key_s && ( !(tree7_Y_Pos + tree_size_Y > tree_Y_Max) ) )
					tree7_Y_Pos_in = tree7_Y_Pos + step_size;
					
				if (keycode  == key_d &&  !(tree7_X_Pos + tree_size_X > tree_X_Max) )
					tree7_X_Pos_in = tree7_X_Pos + step_size;
						
				if (keycode  == key_a && !(tree7_X_Pos < tree_X_Min) )
					tree7_X_Pos_in = tree7_X_Pos - step_size;
					
				//////////////////////////
				
				if (keycode  == key_w && (! (tree8_Y_Pos < tree_Y_Min) ) )
					tree8_Y_Pos_in = tree8_Y_Pos - step_size;				
				
				if (keycode  == key_s && ( !(tree8_Y_Pos + tree_size_Y > tree_Y_Max) ) )
					tree8_Y_Pos_in = tree8_Y_Pos + step_size;
					
				if (keycode  == key_d &&  !(tree8_X_Pos + tree_size_X > tree_X_Max) )
					tree8_X_Pos_in = tree8_X_Pos + step_size;
						
				if (keycode  == key_a && !(tree8_X_Pos < tree_X_Min) )
					tree8_X_Pos_in = tree8_X_Pos - step_size;
					
				//////////////////////////
				
				if (keycode  == key_w && (! (tree9_Y_Pos < tree_Y_Min) ) )
					tree9_Y_Pos_in = tree9_Y_Pos - step_size;				
				
				if (keycode  == key_s && ( !(tree9_Y_Pos + tree_size_Y > tree_Y_Max) ) )
					tree9_Y_Pos_in = tree9_Y_Pos + step_size;
					
				if (keycode  == key_d &&  !(tree9_X_Pos + tree_size_X > tree_X_Max) )
					tree9_X_Pos_in = tree9_X_Pos + step_size;
						
				if (keycode  == key_a && !(tree9_X_Pos < tree_X_Min) )
					tree9_X_Pos_in = tree9_X_Pos - step_size;
					
				//////////////////////////
				
				if (keycode  == key_w && (! (tree10_Y_Pos < tree_Y_Min) ) )
					tree10_Y_Pos_in = tree10_Y_Pos - step_size;				
				
				if (keycode  == key_s && ( !(tree10_Y_Pos + tree_size_Y > tree_Y_Max) ) )
					tree10_Y_Pos_in = tree10_Y_Pos + step_size;
					
				if (keycode  == key_d &&  !(tree10_X_Pos + tree_size_X > tree_X_Max) )
					tree10_X_Pos_in = tree10_X_Pos + step_size;
						
				if (keycode  == key_a && !(tree10_X_Pos < tree_X_Min) )
					tree10_X_Pos_in = tree10_X_Pos - step_size;
					
				//////////////////////////
        
        end
    end
    
	 logic temp1;
	 logic temp2;
	 logic temp3;
	 logic temp4;
	 logic temp5;
	 logic temp6;
	 logic temp7;
	 logic temp8;
	 logic temp9;
	 logic temp10;
	 
	 always_comb
	 begin
		
		
		temp1 = (XX >= tree1_X_Pos && XX <= tree1_X_Pos + tree_size_X)
			  && (YY >= tree1_Y_Pos && YY <= tree1_Y_Pos + tree_size_Y);
			  
		temp2 = (XX >= tree2_X_Pos && XX <= tree2_X_Pos + tree_size_X)
			  && (YY >= tree2_Y_Pos && YY <= tree2_Y_Pos + tree_size_Y);
		
		temp3 = (XX >= tree3_X_Pos && XX <= tree3_X_Pos + tree_size_X)
			  && (YY >= tree3_Y_Pos && YY <= tree3_Y_Pos + tree_size_Y);
		
		temp4 = (XX >= tree4_X_Pos && XX <= tree4_X_Pos + tree_size_X)
			  && (YY >= tree4_Y_Pos && YY <= tree4_Y_Pos + tree_size_Y);
		
		temp5 = (XX >= tree5_X_Pos && XX <= tree5_X_Pos + tree_size_X)
			  && (YY >= tree5_Y_Pos && YY <= tree5_Y_Pos + tree_size_Y);
		
		temp6 = (XX >= tree6_X_Pos && XX <= tree6_X_Pos + tree_size_X)
			  && (YY >= tree6_Y_Pos && YY <= tree6_Y_Pos + tree_size_Y);
		
		temp7 = (XX >= tree7_X_Pos && XX <= tree7_X_Pos + tree_size_X)
			  && (YY >= tree7_Y_Pos && YY <= tree7_Y_Pos + tree_size_Y);
		
		temp8 = (XX >= tree8_X_Pos && XX <= tree8_X_Pos + tree_size_X)
			  && (YY >= tree8_Y_Pos && YY <= tree8_Y_Pos + tree_size_Y);
		
		temp9 = (XX >= tree9_X_Pos && XX <= tree9_X_Pos + tree_size_X)
			  && (YY >= tree9_Y_Pos && YY <= tree9_Y_Pos + tree_size_Y);
		
		temp10 = (XX >= tree10_X_Pos && XX <= tree10_X_Pos + tree_size_X)
			  && (YY >= tree10_Y_Pos && YY <= tree10_Y_Pos + tree_size_Y);
		
	 if(  temp1 || temp2 || temp3 || temp4 || temp5 || temp6 || temp7 || temp8 || temp9 || temp10 )
			is_tree = 1'b1;
		else
			is_tree = 1'b0;
   
	
		pixel_x_in_tree = XX - tree1_X_Pos;
		pixel_y_in_tree = YY - tree1_Y_Pos;
		
		if ( temp1 )
		begin
			pixel_x_in_tree = XX - tree1_X_Pos;
			pixel_y_in_tree = YY - tree1_Y_Pos;
		end
		
		if ( temp2 )
		begin
			pixel_x_in_tree = XX - tree2_X_Pos;
			pixel_y_in_tree = YY - tree2_Y_Pos;
		end
		
		if ( temp3 )
		begin
			pixel_x_in_tree = XX - tree3_X_Pos;
			pixel_y_in_tree = YY - tree3_Y_Pos;
		end
		
		if ( temp4 )
		begin
			pixel_x_in_tree = XX - tree4_X_Pos;
			pixel_y_in_tree = YY - tree4_Y_Pos;
		end
		
		if ( temp5 )
		begin
			pixel_x_in_tree = XX - tree5_X_Pos;
			pixel_y_in_tree = YY - tree5_Y_Pos;
		end
		
		if ( temp6 )
		begin
			pixel_x_in_tree = XX - tree6_X_Pos;
			pixel_y_in_tree = YY - tree6_Y_Pos;
		end
		
		if ( temp7 )
		begin
			pixel_x_in_tree = XX - tree7_X_Pos;
			pixel_y_in_tree = YY - tree7_Y_Pos;
		end
		
		if ( temp8 )
		begin
			pixel_x_in_tree = XX - tree8_X_Pos;
			pixel_y_in_tree = YY - tree8_Y_Pos;
		end
		
		if ( temp9 )
		begin
			pixel_x_in_tree = XX - tree9_X_Pos;
			pixel_y_in_tree = YY - tree9_Y_Pos;
		end
		
		if ( temp10 )
		begin
			pixel_x_in_tree = XX - tree10_X_Pos;
			pixel_y_in_tree = YY - tree10_Y_Pos;
		end
		

		end
	
			  
	
	 
	 
endmodule
