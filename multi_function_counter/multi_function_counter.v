`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:55:12 05/25/2015 
// Design Name: 
// Module Name:    multi_function_counter 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module multi_function_counter(output reg [6:0] digit,
	output reg cout,
	output reg [1:0] word,
	output wire [1:0] word_close,
	input wire [3:0] data,
	input wire [1:0] mod_sel,
	input wire enable,
	input wire reset,
	input wire clock,
	input wire load,
	input wire dir_sel
    );
	
	reg [3:0] data_out;
	reg [31:0] count_1;
	reg [9:0] count_2;
	
	parameter t_1=32'd50000;
	parameter t_2=9'd500;
	
	always @(posedge clock)
	begin
		if(reset)
		begin
			cout<=0;
			data_out<=0;
			count_1<=0;
			count_2<=0;
			word<=2'b01;
		end
		else
		begin
			count_1<=count_1+1;
			if(count_1==t_1)
				count_1<=0;
			count_2<=count_2+1;
			if(count_2==t_2)
				count_2<=0;
	
			if(enable)
			begin
				if(load)
					data_out<=data;
				else if(count_1==(t_1/2))
					case(data_out)
						4'b0000:
						if(dir_sel)
							data_out<=data_out+1;
						else if(mod_sel==0)
						begin
							data_out<=4'b0111;
							cout<=1;
						end
						else if(mod_sel==1)
						begin
							data_out<=4'b1001;
							cout<=1;
						end
						else if(mod_sel==2)
						begin
							data_out<=4'b1111;
							cout<=1;
						end
								
						4'b0110:
						begin
							if(dir_sel)
							begin
								data_out<=data_out+1;
								if(mod_sel==0)
									cout<=1;
							end
							else data_out<=data_out-1;
						end
				
						4'b0111:
						begin
							cout<=0;
							if(dir_sel)
							begin
								if(mod_sel==0)
									data_out<=4'b0000;
								else data_out<=data_out+1;
							end
							else data_out<=data_out-1;
						end
					
						4'b1000:
						begin
							if(mod_sel==0)
							begin
								data_out<=0;
								cout<=0;
							end
							if(mod_sel!=0)
							begin
								if(dir_sel)
								begin
									data_out<=data_out+1;
									if(mod_sel==1)
										cout<=1;
								end
								else data_out<=data_out-1;
							end
						end
						
						4'b1001:
						begin
							if(mod_sel==0)
							begin
								data_out<=0;
								cout<=0;
							end
							if(mod_sel!=0)
							begin
								cout<=0;
								if(dir_sel)
								begin
									if(mod_sel!=2)
										data_out<=4'b0000;
									else data_out<=data_out+1;
								end
								else data_out<=data_out-1;
							end
						end
						
						4'b1010:
						begin
							if(mod_sel!=2)
								begin
									data_out<=0;
									cout<=0;
								end
							if(mod_sel==2)
							begin
								if(dir_sel)
								data_out<=data_out+1;
								else data_out<=data_out-1;
							end
						end
						4'b1011:
						begin
							if(mod_sel!=2)
								begin
									data_out<=0;
									cout<=0;
								end
							if(mod_sel==2)
							begin
								if(dir_sel)
								data_out<=data_out+1;
								else data_out<=data_out-1;
							end
						end
						
						4'b1100:
						begin
							if(mod_sel!=2)
								begin
									data_out<=0;
									cout<=0;
								end
							if(mod_sel==2)
							begin
								if(dir_sel)
								data_out<=data_out+1;
								else data_out<=data_out-1;
							end
						end
						
						4'b1101:
						begin
							if(mod_sel!=2)
								begin
									data_out<=0;
									cout<=0;
								end
							if(mod_sel==2)
							begin
								if(dir_sel)
								data_out<=data_out+1;
								else data_out<=data_out-1;
							end
						end
							
						4'b1110:
						begin
							if(mod_sel!=2)
								begin
									data_out<=0;
									cout<=0;
								end
							if(mod_sel==2)
							begin
								if(dir_sel)
								begin
									data_out<=data_out+1;
									cout<=1;
								end
								else data_out<=data_out-1;
							end
						end
					
						4'b1111:
						begin
							if(mod_sel!=2)
								begin
									data_out<=0;
									cout<=0;
								end
							if(mod_sel==2)
							begin
								cout<=0;
								if(dir_sel)
									data_out<=4'b0000;
								else data_out<=data_out-1;
							end
						end
					
						default:
						if(dir_sel)
							data_out<=data_out+1;
						else data_out<=data_out-1;
					endcase
			end
		end	
		if(count_2==(t_2/2))
		begin
			case(word)
				2'b10:
				begin
					case(data_out)
					4'b0000:digit<=7'b1000000;
					4'b0001:digit<=7'b1111001;
					4'b0010:digit<=7'b0100100;
					4'b0011:digit<=7'b0110000;
					4'b0100:digit<=7'b0011001;
					4'b0101:digit<=7'b0010010;
					4'b0110:digit<=7'b0000010;
					4'b0111:digit<=7'b1111000;
					4'b1000:digit<=7'b0000000;
					4'b1001:digit<=7'b0010000;
					4'b1010:digit<=7'b1000000;
					4'b1011:digit<=7'b1111001;
					4'b1100:digit<=7'b0100100;
					4'b1101:digit<=7'b0110000;
					4'b1110:digit<=7'b0011001;
					4'b1111:digit<=7'b0010010;
					endcase
					word<=2'b01;
				end
				2'b01:
				begin
					if(data_out<=4'b1001)
						digit<=7'b1000000;
					else
						digit<=7'b1111001;
					word<=2'b10;
				end
				default:
					word<=2'b10;
			endcase
		end
	end
	assign word_close=2'b11;
endmodule
