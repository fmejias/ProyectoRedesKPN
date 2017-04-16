module delay_module (
clk,
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


endmodule // end delay_module