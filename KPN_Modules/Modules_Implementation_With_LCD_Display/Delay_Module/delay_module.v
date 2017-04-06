module delay_module (
clk,
data_in,
reset,
data_out,
show_output
);

/*
 * We define the parameters
 */

parameter DELAY_NUMBER = 0; 

/*
 * We define the type of entries and outputs
 */
 
input clk;
input [15:0] data_in; 
input reset;
output [15:0] data_out;
output show_output;


/*
 * We make the delay operation.
 * Also, we enable the show_output signal
 */

 reg [15:0] data_out;
 reg [15:0] delay_register;
 reg show_output;
 
 always @(posedge clk)
 begin
  if(reset)
  begin
	data_out = 16'h0000;
	delay_register = 16'hffff;
	show_output = 1'b0;
  end
  else
  begin
   if(delay_register[DELAY_NUMBER:0] == 0) begin
		data_out = data_in;
		show_output = 1'b1;
	end
	else
	begin
		delay_register = delay_register << 1;
	end
  end
  
 end


endmodule // end split_module