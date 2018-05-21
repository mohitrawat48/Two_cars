
//-------------------------------------------------------------------------
//      
//      
//      
//                          
//      
//      	 	This module takes two keypresses from NIOS at a time 
//				and separates them into two groups player1_key and player2_key                                   
//                                          
//          the output will be zero if no key is pressed by either player                                
//                                          
//                                          
//                                          
//-------------------------------------------------------------------------





module mapkeys(
			input logic [15:0] two_keycodes,
			output logic [7:0] player1_key, player2_key
		);

		//internal signals
		logic[7:0] keycode1, keycode2;
		
		//Grab the two input keycodes
		assign keycode1 = two_keycodes[15:8];
		assign keycode2 = two_keycodes[7:0];
		
		//USB keycodes
		//Player 1
		parameter [7:0] key_w = 8'h1A;
		parameter [7:0] key_s = 8'h16;
		parameter [7:0] key_d = 8'h07;
		parameter [7:0] key_a = 8'h04;
		//Player 2
		parameter [7:0] key_8 = 8'h60;
		parameter [7:0] key_5 = 8'h5D;
		parameter [7:0] key_4 = 8'h5C;
		parameter [7:0] key_6 = 8'h5E;
		
		always_comb
		begin
		
		player1_key = 8'b00;
		player2_key = 8'b00;
	
			//if both keys associate to only 1 player, then both outputs will get 0x00 (eq to pressed ntg for both users)
			if( ((keycode1 == key_w || keycode1 == key_s || keycode1 == key_d || keycode1 ==key_a)
					&&
				 (keycode2 == key_8 || keycode2 == key_5 || keycode2 == key_4 || keycode2 ==key_6)) 
				   ||
				 ((keycode2 == key_w || keycode2 == key_s || keycode2 == key_d || keycode2 ==key_a)
					&&
				 (keycode1 == key_8 || keycode1 == key_5 || keycode1 == key_4 || keycode1 ==key_6))
					||
				 ((keycode2 == key_w || keycode2 == key_s || keycode2 == key_d || keycode2 ==key_a)
					&&
				 ( keycode1 == 0 ) )
					||
				 ((keycode2 == key_8 || keycode2 == key_4 || keycode2 == key_5 || keycode2 == key_6)
					&&
				 ( keycode1 == 0 ) )
				)
				
				// when both keys belong to different players
				begin
				
					case(keycode1)
						key_w: player1_key = key_w;
						key_s: player1_key = key_s;
						key_d: player1_key = key_d;
						key_a: player1_key = key_a;
						key_8: player2_key = key_8;
						key_5: player2_key = key_5;
						key_4: player2_key = key_4;
						key_6: player2_key = key_6;
					endcase
					
					case(keycode2)
						key_w: player1_key = key_w;
						key_s: player1_key = key_s;
						key_d: player1_key = key_d;
						key_a: player1_key = key_a;
						key_8: player2_key = key_8;
						key_5: player2_key = key_5;
						key_4: player2_key = key_4;
						key_6: player2_key = key_6;
					endcase
					
				end
				
				
		end
endmodule
