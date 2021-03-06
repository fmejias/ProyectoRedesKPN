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
 * We define some registers need it to activate the outputs rd and wr
 * 
 */
 
 reg activateRd = 1'b0;
 reg activateWr = 1'b0;


/*
 * We make the split operation.
 */
 
 always @(posedge clk)
 begin
   output_1 = entry_1;
	output_2 = entry_1;
 end
 
 //In this part we activate the rd output
 always @(posedge clk)
 begin
	activateRd = ~activateRd;
 end
 
 //In this part we activate the wr output
 always @(posedge clk)
 begin
	activateWr = ~activateWr;
 end
 
 
/*
 * We set rd and wr
 * 
 */
 
 assign wr = ((activateRd == 1'b1 && activateWr == 1'b1) || (activateRd == 1'b0 && activateWr == 1'b0)) ? 1'b1 : 1'b0;
 assign rd = ((activateRd == 1'b1 && activateWr == 1'b1) || (activateRd == 1'b0 && activateWr == 1'b0)) ? 1'b1 : 1'b0;
 

endmodule // end split_module