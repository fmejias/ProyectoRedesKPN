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
	
 reg [15:0] output_1 = 16'h0000;
 
 reg pruebaRd = 1'b0;
 reg pruebaWr = 1'b0;
 
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
 
 always @(posedge clk)
 begin
	pruebaRd = ~pruebaRd;
 end
 
  always @(posedge clk)
 begin
	pruebaWr = ~pruebaWr;
 end
 
 
 /*
 * We set rd and wr
 * 
 */
 
 assign wr = (clk == 1'b1) ? 1'b1 : 1'b0;
// assign rd = (clk == 1'b1) ? 1'b1 : 1'b0;
 
 assign rd = ((pruebaRd == 1'b1 && pruebaWr == 1'b1) || (pruebaRd == 1'b0 && pruebaWr == 1'b0)) ? 1'b1 : 1'b0;
// assign rd = ((pruebaRd == 1'b1 || pruebaRd == 1'b0)) ? 1'b1 : 1'b0;
 //assign wr = ((pruebaRd == 1'b1 && pruebaWr == 1'b1) || (pruebaRd == 1'b0 && pruebaWr == 1'b0)) ? 1'b1 : 1'b0;


endmodule // end adder_module