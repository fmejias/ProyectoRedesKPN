module adder_module (
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
 * We enable rd
 * 
 */
 //always @(posedge clk)
 //begin
//	wr = 1'b0;
//	rd = 1'b1;
 //end
 
 /*
 * We enable wr
 * 
 */
 /*always @(posedge clk or negedge clk)
 begin
	if(clk == 1'b1)
	begin
	wr = 1'b0;
	rd = 1'b1;
	end
	else
	begin
	wr = 1'b1;
	rd = 1'b0;
	end
	
 end*/
 
/*
 * We make the add operation.
 * 
 */
 
 always @(posedge clk)
 begin
  output_1 = entry_1 + entry_2;
  $display("La entrada 1 es:", entry_1);
  $display("La entrada 2 es:", entry_2);
  $display("La salida es:", output_1);
 end
 
 assign wr = (clk == 1'b1) ? 1'b0 : 1'b1;
 assign rd = (clk == 1'b1) ? 1'b1 : 1'b0;


endmodule // end adder_module