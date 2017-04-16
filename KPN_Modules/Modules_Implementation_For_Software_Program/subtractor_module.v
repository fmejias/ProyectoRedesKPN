module subtractor_module (
clk,
rd,
wr,
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
output [15:0] output_1;
output wr;
output rd;


/*
 * We define the type of outputs
 * 
 */
	
 reg [15:0] output_1;


 /*
 * We make the subtract operation.
 * 
 */
 
 always @(posedge clk)
 begin
  output_1 = entry_1 - entry_2;
 end
 
 /*
 * We set rd and wr
 * 
 */
 
 assign wr = (clk == 1'b1) ? 1'b0 : 1'b1;
 assign rd = (clk == 1'b1) ? 1'b1 : 1'b0;


endmodule // end subtractor_module