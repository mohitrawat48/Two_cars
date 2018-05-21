/*
	This is onchip memory
	which reads outputs data from onchip (M9k) memory block
	based on input address.
	
	The onchip memory can have any design,
	meaning the address width and data width 
	can be chosen as desired
	
	This is where our sprites are stored that is,
	red car,blue car, yellow car, tree
	
*/

module  onchip
(
		input logic [16:0] read_address,
		input logic Clk,
		output logic [15:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [15:0] mem [0:28299];

initial
begin
	 $readmemh("sprites/sprite_onchip.txt", mem);
end


always_ff @ (posedge Clk) begin
	data_Out<= mem[read_address];
end

endmodule
