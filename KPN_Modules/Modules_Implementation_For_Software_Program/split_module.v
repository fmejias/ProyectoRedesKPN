module split_module (
clk,
rd,
wr,
entry_1,
output_1,
output_2
);

/*
 * We define the entries and outputs
 */

input clk;
input [15:0] entry_1; 
output [15:0] output_1;
output [15:0] output_2;
output wr;
output rd;


/*
 * We define the type of outputs
 * 
 */
	
 reg [15:0] output_1;
 reg [15:0] output_2;


/*
 * We make the split operation.
 */
 
 always @(posedge clk)
 begin
   output_1 = entry_1;
	output_2 = entry_1;
 end
 
 /*
 * We set rd and wr
 * 
 */
 
 assign wr = (clk == 1'b1) ? 1'b0 : 1'b1;
 assign rd = (clk == 1'b1) ? 1'b1 : 1'b0;


endmodule // end split_module