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
  * We define registers need it to convert the entry to the correct form
  *
  */
 reg [15:0] thousands_entry_1; 
 reg [15:0] hundreds_entry_1; 
 reg [15:0] tens_entry_1;
 reg [15:0] ones_entry_1;
 
 reg [15:0] thousands_entry_2;
 reg [15:0] hundreds_entry_2; 
 reg [15:0] tens_entry_2;
 reg [15:0] ones_entry_2;
 
 reg [15:0] transformed_entry_1;
 reg [15:0] transformed_entry_2;

 
/*
 * We make the add operation.
 * 
 */
 
 always @(posedge clk)
 begin
 
	/*
	 * Conversion of entry_1
	 */
	ones_entry_1 = entry_1[3:0];
	tens_entry_1 = (entry_1[7:4] << 3) + (entry_1[7:4] << 1);
	hundreds_entry_1 = (entry_1[11:8] << 6) + (entry_1[11:8] << 5) + (entry_1[11:8] << 2);
	thousands_entry_1 = (entry_1[15:12] << 9) + (entry_1[15:12] << 8) + (entry_1[15:12] << 7)
								+ (entry_1[15:12] << 6) + (entry_1[15:12] << 5) + (entry_1[15:12] << 3);
								
	transformed_entry_1 = thousands_entry_1 + hundreds_entry_1 + tens_entry_1 + ones_entry_1;
	
	/*
	 * Conversion of entry_2
	 */
	ones_entry_2 = entry_2[3:0];
	tens_entry_2 = (entry_2[7:4] << 3) + (entry_2[7:4] << 1);
	hundreds_entry_2 = (entry_2[11:8] << 6) + (entry_2[11:8] << 5) + (entry_2[11:8] << 2);
	thousands_entry_2 = (entry_2[11:8] << 6) + (entry_2[11:8] << 5) + (entry_2[11:8] << 2);
	transformed_entry_2 = thousands_entry_2 + hundreds_entry_2 + tens_entry_2 + ones_entry_2;
	
  
  
  //Assign the corresponding bits to the output_1
  output_1 = transformed_entry_1 + transformed_entry_2;
  
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