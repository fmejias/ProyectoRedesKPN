module delay_module (
clk,
rd,
wr,
entry_1,
output_1
);


/*
 * We define the parameters
 */

parameter DELAY_NUMBER = 0; 

/*
 * We define the type of entries and outputs
 */
 
input clk;
input [15:0] entry_1; 
output [15:0] output_1;
output wr;
output rd;


/*
 * We make the delay operation.
 * 
 */

 reg [15:0] output_1;
 reg [15:0] delay_register = 16'hffff;
 reg already_delay = 1'b0;
 
 always @(posedge clk)
 begin
	if(delay_register[DELAY_NUMBER-1:0] == 0 && already_delay == 0) begin
		output_1 = entry_1;
		already_delay = 1'b1;
	end
	else if(already_delay == 1'b1) begin
		output_1 = entry_1;
	end
	else
	begin
		delay_register = delay_register << 1;
		output_1 = 16'h0000;
	end 
  
 end
 
 /*
 * We set rd and wr
 * 
 */
 
 assign wr = (clk == 1'b1) ? 1'b0 : 1'b1;
 assign rd = (clk == 1'b1) ? 1'b1 : 1'b0;


endmodule // end delay_module