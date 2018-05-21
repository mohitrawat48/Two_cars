/*

	This is the game state machine
	controls game transitions
	
	that is menu->3->2->1->GO->play->end


*/
module control (input  logic Clk, Reset, p1win, p2win,
					 input logic [7:0] keycode,
                output logic showMenu, show3, show2, show1, showGo, showp1win, showp2win,
					 output logic [9:0]  traffic_step_size,tree_step_size,
					 output logic [7:0] keycode_control
  					 );
	 
	 
	 
	 // 10 states
	 enum logic [3:0] {
		WAIT, THREE, TWO, ONE, GO,PLAY1,
		PLAY, WINP1, WINP2}   curr_state, next_state;
		
	//internal logic
	parameter  logic [7:0] ENTER_KEY = 8'h28;
	parameter  logic [7:0] key_s = 8'h16;
	
	
	logic [63:0] counter,counter_in;
	logic [7:0] tf_s,tf_s_in,t_s,t_s_in;
	
	assign traffic_step_size = tf_s;
	assign tree_step_size = t_s;
	
	

	//Sequential: Clk and Reset
    always_ff @ (posedge Clk or posedge Reset)  
    begin
        if (Reset)  //asynchronous
		  begin
            curr_state <= WAIT;
				counter <= 0;
				t_s <= 0;
				tf_s <= 0;
		  end
        else 
		  begin
			curr_state <= next_state;
		   counter <= counter_in;
			t_s <= t_s_in;
			tf_s <= tf_s_in;
		  end
	end

    //Combinational: outputs and state transitions
	 always_comb
    begin
        
		  //state transitions
		  next_state  = curr_state;	//default stay in the current state
		  
		  counter_in = counter;
		  t_s_in = t_s;
		  tf_s_in = tf_s;
		  
		  ///default output values
		  
		  showMenu = 0; 
		  show3 = 0;
		  show2 = 0;
		  show1 = 0;
		  showGo = 0;
		  showp1win = 0;
		  showp2win = 0;
		  
		  keycode_control = 0;
  					 
        unique case (curr_state) 

            WAIT :
					if(keycode == ENTER_KEY)
						next_state = THREE;
				THREE:
				begin
					counter_in = counter + 1;

					if( counter == 150000000 )
					begin
						next_state = TWO;
						counter_in = 0;
					end
				end	
				TWO  : 
				begin
					counter_in = counter + 1;

					if( counter == 150000000 )
					begin
						next_state = ONE;
						counter_in = 0;
					end
				end
				ONE  : 
				begin
					counter_in = counter + 1;

					if( counter == 150000000 )
					begin
						next_state = GO;
						counter_in = 0;
					end
				end
				GO   :
				begin
					counter_in = counter + 1;

					if( counter == 150000000 )
					begin
						next_state = PLAY1;
						counter_in = 0;
					end
				end
				
				PLAY1:
				begin
					tf_s_in = tf_s + 2;
					t_s_in = t_s + 4;
					next_state = PLAY;
				end
				
				PLAY:
				begin
					counter_in = counter + 1;
					

					if( counter == 1800000000 )
					begin
						tf_s_in = tf_s + 2;
						t_s_in = t_s + 4;
						counter_in = 0;
					end
					
					if(p1win)
					begin
						next_state = WINP1;
						counter_in = 0 ;
					end
					
					if(p2win)
					begin
						next_state = WINP2;
						counter_in = 0;
					end
					
					
				end
				
				
				WINP1:
				begin
					counter_in = counter + 1;

					if( counter == 800000000 )
					begin
						next_state = WAIT;
						counter_in = 0;
					end
				end
				
				WINP2:
				begin
					counter_in = counter + 1;

					if( counter == 800000000 )
					begin
						next_state = WAIT;
						counter_in = 0;
					end
				end
				
							  
        endcase

		  
        case (curr_state) 
	   	   WAIT: 
	         begin
                showMenu = 1'b1;
		      end
				
				THREE: 
	         begin
					 show3 = 1'b1;
		      end
				
				TWO: 
	         begin
					 show2 = 1'b1;
		      end
				
				ONE: 
	         begin
					 show1 = 1'b1;
		      end
				
				GO: 
	         begin
					 showGo = 1'b1;
		      end
				
				PLAY1: 
	         begin
					 keycode_control = key_s;
		      end
				
				PLAY: 
	         begin
					 keycode_control = key_s;
		      end
				
				WINP1: 
	         begin
					 showp1win = 1'b1;
		      end
				
				WINP2: 
	         begin
					 showp2win = 1'b1;
		      end
	   	   
        endcase
		
    end


endmodule
