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
  * We define the registers need it to save the integer and the decimal values
  *
  */
 reg [11:0] integer_part_entry_1 = 12'h000;
 reg [11:0] integer_part_entry_2 = 12'h000;
 reg [11:0] integer_result = 12'h000;
 reg [3:0] decimal_part_entry_1 = 4'h0;
 reg [3:0] decimal_part_entry_2 = 4'h0;
 reg [3:0] decimal_result = 4'h0;


 /*
 * We make the subtract operation.
 * 
 */
 
 always @(posedge clk)
 begin
 
  //Extract the integer part of the entries
  integer_part_entry_1 = entry_1[15:4];
  integer_part_entry_2 = entry_2[15:4];
  
  //Extract the decimal part of the entries
  decimal_part_entry_1 = entry_1[3:0];
  decimal_part_entry_2 = entry_2[3:0];
  
  //Subtract the integer part
  integer_result = integer_part_entry_1 - integer_part_entry_2;
  
  //Checks if the decimal_part_entry_1 is smaller than the decimal_part_entry_2
  if(decimal_part_entry_1 >= decimal_part_entry_2)
  begin
	decimal_result = decimal_part_entry_1 - decimal_part_entry_2;
  end
  else
  begin
	decimal_result = (decimal_part_entry_1 + 4'b1010) - decimal_part_entry_2;
	integer_result = integer_result - 1;
  end
  
  //Assign the corresponding bits to the output_1
  output_1[15:4] = integer_result;
  output_1[3:0] = decimal_result;
  
  //Shows the output on the testbench
  $display("La entrada 1 es:", entry_1[15:4], ",", entry_1[3:0]);
  $display("La entrada 2 es:", entry_2[15:4], ",", entry_2[3:0]);
  $display("La salida es:", output_1[15:4], ",", output_1[3:0]);
  
 end
 
 /*
 * We set rd and wr
 * 
 */
 
 assign wr = (clk == 1'b1) ? 1'b0 : 1'b1;
 assign rd = (clk == 1'b1) ? 1'b1 : 1'b0;


endmodule // end subtractor_module