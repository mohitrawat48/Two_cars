/*

Description: A state machine which takes in a three-bit random number and 
decides which cars should come from the top. The cars are numbered as 1st, 2nd and 3rd. 
The random number decides how many cars and which car come from the top.
The random number also decides after how many seconds, the cars are sent. 

Purpose: To control position of all three yellow cars based on random number.


*/


module lane_control (input logic         Clk, 
													  Reset,
							input logic [2:0] random_number,
							
							input logic [7:0] keycode_of_s,
							
							input integer car1_pos_max,car2_pos_max,car3_pos_max,
							input integer car1_pos,car2_pos,car3_pos,
							output logic [7:0] keycode_s1,keycode_s2,keycode_s3,
							
							input integer yellowcar1_Y_Min,		
							input integer yellowcar2_Y_Min,
							input integer yellowcar3_Y_Min
									
				);

	enum logic [3:0] { none,none_next,move1,move1_next,move2,move2_next,move3,move3_next,move12,move12_next
							,move13,move13_next,move23,move23_next }State, Next_state;   // Internal state logic
	
	
	 parameter integer yellowcar_size_X = 10'd49;        
	 parameter integer yellowcar_size_Y = 10'd99; 
	 
	 
	 integer counter,counter_in,limit,limit_in,counter_limit;
	 
	 assign counter_limit = limit * 50000000;
	
parameter logic [2:0] t1 = 3'b000;
parameter logic [2:0] t2 = 3'b001;
parameter logic [2:0] t3 = 3'b010;
parameter logic [2:0] t4 = 3'b011;
parameter logic [2:0] t5 = 3'b100;
parameter logic [2:0] t6 = 3'b101;
parameter logic [2:0] t7 = 3'b110;
parameter logic [2:0] t8 = 3'b111;	
	
	always_ff @ (posedge Clk)
	begin
		if (Reset) 
		begin
			State   <= none_next;
			counter <= 0;
			limit   <= 1;
		end
		else 
		begin
			State   <= Next_state;
			counter <= counter_in;
			limit   <= limit_in;
		end
	end
   
	
	always_comb
	begin 
	
		counter_in = counter + 1;
		
		limit_in = limit;
	
	
		// Default next state is staying at current state
		Next_state = State;
		
		// Default controls signal values
		keycode_s1 = 0;
		keycode_s2 = 0;
		keycode_s3 = 0;

		// Assign next state
		unique case (State)
			none : 
			begin
			
				if( counter >= counter_limit )		
				begin
					Next_state = none_next;
					counter_in = 0;
				end
			
			end
			none_next:
			begin
						
					if( random_number == t1 )
					begin
						Next_state = move1;
					end
					if( random_number == t2 )
					begin
						Next_state = move2;
					end
					if( random_number == t3 )
					begin
						Next_state = move3;
					end
					if( random_number == t4 )
					begin
						Next_state = move12;	
					end
					if( random_number == t5 )
					begin
						Next_state = move13;	
					end
					if( random_number == t6 )
					begin
						Next_state = move23;
					end
					if( random_number == t7 )
					begin
						Next_state = move13;
					end
					if( random_number == t8 )
					begin
						Next_state = move12;
					end

						
			end
			
			move1:
			begin
				if( ( car1_pos > ( yellowcar1_Y_Min + 10'd5 ) ) )
				begin
					Next_state = move1_next;
				end
			end	
			
			move1_next:
			begin
				if( car1_pos == yellowcar1_Y_Min )
				begin 
					Next_state = none;
				end
			end
			///////
			move2:
			begin
				if( ( car2_pos > ( yellowcar2_Y_Min + 10'd5 ) ) )
				begin
					Next_state = move2_next;
				end
			end	
			
			move2_next:
			begin
				if( car2_pos == yellowcar2_Y_Min )
				begin 
					Next_state = none;
				end
			end
			//////////////
			move3:
			begin
				if( ( car3_pos > ( yellowcar3_Y_Min + 10'd5 ) ) )
				begin 
					Next_state = move3_next;
				end
			end	
			
			move3_next:
			begin
				if( car3_pos == yellowcar3_Y_Min )
				begin 
					Next_state = none;
				end
			end
			//////
			move12:
			begin
				if( ( car1_pos > ( yellowcar1_Y_Min + 10'd5 ) ) ) 
				begin
					Next_state = move12_next;
				end
			end	
			
			move12_next:
			begin
				if( car1_pos == yellowcar1_Y_Min )
				begin 
					Next_state = none;
				end
			end
			
			move13:
			begin
				if( ( car1_pos  > ( yellowcar1_Y_Min + 10'd5 ) ) )
				begin 
					Next_state = move13_next;
				end
			end	
			
			move13_next:
			begin
				if( car1_pos == yellowcar1_Y_Min )
				begin 
					Next_state = none;
				end
			end
			
			move23:
			begin
				if( ( car2_pos  > ( yellowcar2_Y_Min + 10'd5 ) ) )
				begin
					Next_state = move23_next;
				end
			end	
			
			move23_next:
			begin
				if( car2_pos == yellowcar2_Y_Min )
				begin 
					Next_state = none;
				end
			end
			

			default :;
		endcase
		
		// Assign control signals based on current state
		case (State)
			none:
			begin
				keycode_s1 = 0;
				keycode_s2 = 0;
				keycode_s3 = 0;
			end
			none_next:
			begin
				keycode_s1 = 0;
				keycode_s2 = 0;
				keycode_s3 = 0;
			end
			move1 : 
			begin 
				keycode_s1 = keycode_of_s;
				keycode_s2 = 0;
				keycode_s3 = 0;
			end
			move1_next : 
			begin 
				keycode_s1 = keycode_of_s;
				keycode_s2 = 0;
				keycode_s3 = 0;
				counter_in = 0;
				limit_in = random_number ;
			end
			move2 : 
			begin 
				keycode_s1 = 0;
				keycode_s2 = keycode_of_s;
				keycode_s3 = 0;
			end
			move2_next : 
			begin 
				keycode_s1 = 0;
				keycode_s2 = keycode_of_s;
				keycode_s3 = 0;
				counter_in = 0;
				limit_in = random_number ;
			end
			move3 : 
			begin 
				keycode_s1 = 0;
				keycode_s2 = 0;
				keycode_s3 = keycode_of_s;
			end
			move3_next : 
			begin 
				keycode_s1 = 0;
				keycode_s2 = 0;
				keycode_s3 = keycode_of_s;
				counter_in = 0;
				limit_in = random_number ;
			end
			move12 : 
			begin 
				keycode_s1 = keycode_of_s;
				keycode_s2 = keycode_of_s;
				keycode_s3 = 0;
			end
			move12_next : 
			begin 
				keycode_s1 = keycode_of_s;
				keycode_s2 = keycode_of_s;
				keycode_s3 = 0;
				counter_in = 0;
				limit_in = random_number ;
			end
			move13 : 
			begin 
				keycode_s1 = keycode_of_s;
				keycode_s2 = 0;
				keycode_s3 = keycode_of_s;
			end
			move13_next : 
			begin 
				keycode_s1 = keycode_of_s;
				keycode_s2 = 0;
				keycode_s3 = keycode_of_s;
				counter_in = 0;
				limit_in = random_number ;
			end
			move23 : 
			begin 
				keycode_s1 = 0;
				keycode_s2 = keycode_of_s;
				keycode_s3 = keycode_of_s;
			end
			move23_next : 
			begin 
				keycode_s1 = 0;
				keycode_s2 = keycode_of_s;
				keycode_s3 = keycode_of_s;
				counter_in = 0;
				limit_in = random_number ;
			end
			
			default : ;
		endcase
	end 

	
endmodule
