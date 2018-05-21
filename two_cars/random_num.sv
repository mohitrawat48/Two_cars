/*

Description: Based on a 32-bit wide seed value, it generates a 3-bit wide and 
 			a single-bit random number. We use a linear feedback shift register
 			to randomize the seed value. It performs XOR operation on bit
number 32, 22, 2, and 1 and feedbacks into LSB.

Purpose: To randomize the position and number of incoming yellow cars.



*/

module random_num(
    input logic Clk,
    input logic Reset,
    output logic [2:0] rand_a_num,
	 output logic  rand_b_num,
	 input logic [31:0] seed 
    );
 
 
 logic [31:0] random,random_in;
 
 logic [31:0]feedback;
 assign feedback = {31'b0 , ( random[31] ^ random[21] ^ random[1] ^ random[0] ) }; 
 
 assign	rand_a_num = random[2:0];
 assign  rand_b_num = random[31];
 
 
always @ (posedge Clk or posedge Reset)
begin
 if (Reset)
 begin
	random = seed;
 end

 else
 begin
 random <= random_in; 
 end
end
 
always_comb
begin	

	random_in = ( random << 1 ) | feedback ;
	
end
 
endmodule
