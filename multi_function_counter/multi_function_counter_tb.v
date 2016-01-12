`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:14:45 05/26/2015
// Design Name:   multi_function_counter
// Module Name:   E:/Pure_Path/Projects/FPGA/FPGA_Course/multi_function_counter/multi_function_counter_tb.v
// Project Name:  multi_function_counter
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: multi_function_counter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module multi_function_counter_tb;

	// Inputs
	reg [3:0] data;
	reg [1:0] mod_sel;
	reg enable;
	reg reset;
	reg clock;
	reg load;
	reg dir_sel;

	// Outputs
	wire [6:0] digit;
	wire cout;
	wire [1:0] word;

	// Instantiate the Unit Under Test (UUT)
	multi_function_counter uut (
		.digit(digit),
		.word(word),
		.cout(cout), 
		.data(data), 
		.mod_sel(mod_sel), 
		.enable(enable), 
		.reset(reset), 
		.clock(clock), 
		.load(load), 
		.dir_sel(dir_sel)
	);

	initial begin
		// Initialize Inputs
		data = 0;
		mod_sel = 2;
		enable = 1;
		reset = 1;
		clock = 0;
		load = 0;
		dir_sel = 1;
		
		#10
		reset=1;
		
		#10
		reset=0;
		load=1;
		#5
		load=0;
		
		#12000000
		mod_sel = 0;
       
		// Add stimulus here

	end
	
	always
	begin
			#10 clock=~clock;
	end
      
endmodule

