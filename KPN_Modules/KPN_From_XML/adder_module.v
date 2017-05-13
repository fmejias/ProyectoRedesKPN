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
 
/*
 * We define some registers need it to activate the outputs rd and wr
 * 
 */
 
 reg activateRd = 1'b0;
 reg activateWr = 1'b0;
 
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
 * We make the add operation.
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
  
  //Add the integer part
  integer_result = integer_part_entry_1 + integer_part_entry_2;
  
  //Add the decimal part
  decimal_result = decimal_part_entry_1 + decimal_part_entry_2;
  
  //Checks if the decimal result is bigger or equal than 10
  if(decimal_result >= 4'd10)
  begin
	decimal_result = decimal_result - 4'b1010; //Performs the subtract: decimal_result - 10
	integer_result = integer_result + 1; //Add 1 to the Integer part
  end
  
  //Assign the corresponding bits to the output_1
  output_1[15:4] = integer_result;
  output_1[3:0] = decimal_result;
  
  
  //Shows the output on the testbench
  $display("La entrada 1 es:", entry_1[15:4], ",", entry_1[3:0]);
  $display("La entrada 2 es:", entry_2[15:4], ",", entry_2[3:0]);
  $display("La salida es:", output_1[15:4], ",", output_1[3:0]);
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

endmodule // end adder_module