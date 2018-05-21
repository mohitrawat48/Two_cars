//-------------------------------------------------------------------------
//      
//      
//      
//              
//          fetches data from flash memory and sends to audio chip (WM8731)
//          for this we need a state machine
//          see documentation for detailed info on state machine
//				Also read comments in 'audio_interface.vhd'
//
//				
//     		In brief, we need to set 'Init' signal to 1 which is the 
//			   input signal to audio_interface module
//				then wait for Init_Finish to go high 
//				Once Init_Finish = 1, fetch 16 bit sample 
//				On 'data_over' rising edge send 16 bit sample 
//				to audio_interface module
//							
//-------------------------------------------------------------------------







module audio_monitor (
	input logic Clk, Reset,
	input logic AUD_ADCDAT, AUD_DACLRCK, AUD_ADCLRCK, AUD_BCLK,
	output logic AUD_DACDAT, AUD_XCK, I2C_SCLK, I2C_SDAT,

	
	output logic [22:0] FL_ADDR,
	input logic [7:0] FL_DQ,
	output logic FL_WE_N,FL_RST_N,FL_WP_N,FL_CE_N,FL_OE_N
	
	//input logic FL_RY
	
	);

	//flash memory control signals are active low
	//we only want to read hence writing signals are disabled
	//and only 'chip_enable' and 'output_enable' are enabled
	assign FL_WE_N    = 1'b1;
	assign FL_RST_N   = 1'b1;
	assign FL_WP_N    = 1'b1;
	
	assign FL_CE_N    = 1'b0;
	assign FL_OE_N    = 1'b0;



logic [15:0] LData, RData, LData_in, RData_in;



logic [15:0] Left_Data, Right_Data, Left_Data_in, Right_Data_in;

logic [7:0] data_one,data_two;

logic [31:0] ADCData;
logic Init, Init_Finish, ADC_Full, data_over , data_over_delayed , data_over_rising_edge ;


logic [22:0] flash_address,flash_address_in;

assign FL_ADDR = flash_address;

enum logic [2:0] {RESET, INITIALIZATION, fetch_byte_one,fetch_byte_two,byte_load} state, next_state;

//audio_interface module 
audio_interface audioif(.LDATA(Left_Data), .RDATA(Right_Data), .clk(Clk), .Reset(Reset),
								.INIT(Init), .INIT_FINISH(Init_Finish), .adc_full(ADC_Full),
								.data_over(data_over), .AUD_MCLK(AUD_XCK), .AUD_BCLK(AUD_BCLK), .AUD_DACDAT(AUD_DACDAT),
								.AUD_ADCDAT(AUD_ADCDAT), .AUD_DACLRCK(AUD_DACLRCK), .AUD_ADCLRCK(AUD_ADCLRCK), 
								.I2C_SDAT(I2C_SDAT), .I2C_SCLK(I2C_SCLK), .ADCDATA(ADCData) );

	//finding rising edge from 'data_over' signal
	always_ff @ (posedge Clk) begin
        data_over_delayed <= data_over;
        data_over_rising_edge <= (data_over == 1'b1) && (data_over_delayed == 1'b0);
    end
								
								
always_ff @ (posedge Clk or posedge Reset)
begin




	if (Reset)begin
		state <= RESET;
		flash_address <= 0;
		LData = 0;
		RData = 0;
		Left_Data = 0;
		Right_Data = 0;
	end
	else
	begin
		state <= next_state;
		LData <= LData_in;
		RData <= RData_in;
		flash_address <= flash_address_in;
		Left_Data <= Left_Data_in;
		Right_Data <= Right_Data_in;
	end
end

always_comb
begin
	// Next state logic
	next_state = state;
	
	flash_address_in = flash_address;
	
	
	// Logic controls
	Init = 1'b0;
	LData_in = LData;
	RData_in = RData;
	Left_Data_in = Left_Data;
	Right_Data_in = Right_Data;
	
	
	
	
	
	case (state)
		RESET: begin
			next_state = INITIALIZATION;
		end
		INITIALIZATION: begin
		
			if (Init_Finish)
				next_state = fetch_byte_one;
				
		end
		fetch_byte_one: begin
		
			flash_address_in = flash_address + 1;
			LData_in[7:0] = FL_DQ;
			RData_in[7:0] = FL_DQ;
			next_state = fetch_byte_two;
			
		end
		
		fetch_byte_two: begin
		
			
			flash_address_in = flash_address + 1;
			LData_in[15:8] = FL_DQ;
			RData_in[15:8] = FL_DQ;
			next_state = byte_load;
			
		end
		
		byte_load:begin
		
			
			if ( data_over_rising_edge) begin
				Left_Data_in = LData;
				Right_Data_in = RData;
				next_state = fetch_byte_one;
			end
			
			if( flash_address >=  23'h24c5e0 ) begin
				flash_address_in = 0;
			end
		
		
		end
		
		
		
	endcase

	case (state)
	
		INITIALIZATION: begin
			Init = 1'b1;
		end
		
	endcase
end
endmodule