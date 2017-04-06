module split_module (
entry_1,
reset,
entry_1_finished,
output_1,
output_2,
show_outputs
);

/*
 * We define the type of entries and outputs
 */

input [15:0] entry_1; 
input reset;
input entry_1_finished;
output [15:0] output_1;
output [15:0] output_2;
output show_outputs;


/*
 * We make the split operation.
 * Also, we enable the show_outputs signal
 */

 reg [15:0] output_1;
 reg [15:0] output_2;
 reg show_outputs;
 
 always @(*)
 begin
  if(reset)
  begin
	output_1 = 16'h0000;
	output_2 = 16'h0000;
	show_outputs = 1'b0;
  end
  else
  begin
   output_1 = entry_1;
	output_2 = entry_1;
	if(entry_1_finished == 1'b1)
	begin
		show_outputs = 1'b1;
	end
	
  end
  
 end


endmodule // end split_module