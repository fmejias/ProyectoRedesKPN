module multiplier_module (
clk,
entry_1,
entry_2,
output_1
);

/*
 * We define the entries and outputs
 */

input clk;
input [15:0] entry_1;
input [15:0] entry_2; 
output [31:0] output_1;

/*
 * We define the type of outputs
 * 
 */
	
 reg [31:0] output_1;


/*
 * We make the mult operation.
 * 
 */

 reg [31:0] mult_1;
 reg [31:0] mult_2;
 reg [31:0] mult_3;
 reg [31:0] mult_4;
 reg [31:0] mult_5;
 reg [31:0] mult_6;
 reg [31:0] mult_7;
 reg [31:0] mult_8;
 reg [31:0] mult_9;
 reg [31:0] mult_10;
 reg [31:0] mult_11;
 reg [31:0] mult_12;
 reg [31:0] mult_13;
 reg [31:0] mult_14;
 reg [31:0] mult_15;
 reg [31:0] mult_16; 
 reg [31:0] result;
 
 
 //This reg is use to do the and operation of number1 and number2[i]
 reg [15:0] and_number = 16'h0000; 

 
 always @(posedge clk)
 begin
	and_number = (entry_2[0] == 1'b1) ? 16'hffff : 16'h0000;
	mult_1 = entry_1 & and_number;
	and_number = (entry_2[1] == 1'b1) ? 16'hffff: 16'h0000;
	mult_2 = entry_1 & and_number;
	mult_2 = mult_2 << 1;
	and_number = (entry_2[2] == 1'b1) ? 16'hffff : 16'h0000;
	mult_3 = entry_1 & and_number;
	mult_3 = mult_3 << 2;
	and_number = (entry_2[3] == 1'b1) ? 16'hffff : 16'h0000;
	mult_4 = entry_1 & and_number;
	mult_4 = mult_4 << 3;
	and_number = (entry_2[4] == 1'b1) ? 16'hffff : 16'h0000;
	mult_5 = entry_1 & and_number;
	mult_5 = mult_5 << 4;
	and_number = (entry_2[5] == 1'b1) ? 16'hffff : 16'h0000;
	mult_6 = entry_1 & and_number;
	mult_6 = mult_6 << 5;
	and_number = (entry_2[6] == 1'b1) ? 16'hffff : 16'h0000;
	mult_7 = entry_1 & and_number;
	mult_7 = mult_7 << 6;
	and_number = (entry_2[7] == 1'b1) ? 16'hffff : 16'h0000;
	mult_8 = entry_1 & and_number;
	mult_8 = mult_8 << 7;
	and_number = (entry_2[8] == 1'b1) ? 16'hffff : 16'h0000;
	mult_9 = entry_1 & and_number;
	mult_9 = mult_9 << 8;
	and_number = (entry_2[9] == 1'b1) ? 16'hffff : 16'h0000;
	mult_10 = entry_1 & and_number;
	mult_10 = mult_10 << 9;
	and_number = (entry_2[10] == 1'b1) ? 16'hffff : 16'h0000;
	mult_11 = entry_1 & and_number;
	mult_11= mult_11 << 10;
	and_number = (entry_2[11] == 1'b1) ? 16'hffff : 16'h0000;
	mult_12 = entry_1 & and_number;
	mult_12 = mult_12 << 11;
	and_number = (entry_2[12] == 1'b1) ? 16'hffff : 16'h0000;
	mult_13 = entry_1 & and_number;
	mult_13 = mult_13 << 12;
	and_number = (entry_2[13] == 1'b1) ? 16'hffff : 16'h0000;
	mult_14 = entry_1 & and_number;
	mult_14 = mult_14 << 13;
	and_number = (entry_2[14] == 1'b1) ? 16'hffff : 16'h0000;
	mult_15 = entry_1 & and_number;
	mult_15 = mult_15 << 14;
	and_number = (entry_2[15] == 1'b1) ? 16'hffff : 16'h0000;
	mult_16 = entry_1 & and_number;
	mult_16 = mult_16 << 15;

	output_1 = mult_1 + mult_2;
	output_1 = output_1 + mult_3;
	output_1 = output_1 + mult_4;
	output_1 = output_1 + mult_5;
	output_1 = output_1 + mult_6;
	output_1 = output_1 + mult_7;
	output_1 = output_1 + mult_8;
	output_1 = output_1 + mult_9;
	output_1 = output_1 + mult_10;
	output_1 = output_1 + mult_11;
	output_1 = output_1 + mult_12;
	output_1 = output_1 + mult_13;
	output_1 = output_1 + mult_14;
	output_1 = output_1 + mult_15;
	output_1 = output_1 + mult_16; 

 end

endmodule // end multiplier_module