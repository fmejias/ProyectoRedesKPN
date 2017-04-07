module adder_module (
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
output [15:0] output_1;


/*
 * We define the type of outputs
 * 
 */
	
 reg [15:0] output_1;
 
 
/*
 * We make the add operation.
 * 
 */
 
 always @(posedge clk)
 begin
  output_1 = entry_1 + entry_2;
 end


endmodule // end adder_module