module multiplier_module (
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
output [31:0] output_1;
output wr;
output rd;

/*
 * We define the type of outputs
 * 
 */
	
 reg [31:0] output_1;
 
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
 reg [11:0] integer_result = 12'h000;
 reg [3:0] decimal_result = 4'h0;
 
 
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
 * We make the mult operation.
 * 
 */

 reg [31:0] mult_1;
 reg [31:0] mult_2;
 reg [31:0] mult_3;
 reg [31:0] mult_4;
 reg [31:0] mult_5;
 reg [31:0] mult_6;
 reg [31:0] mult_7;
 reg [31:0] mult_8;
 reg [31:0] mult_9;
 reg [31:0] mult_10;
 reg [31:0] mult_11;
 reg [31:0] mult_12;
 reg [31:0] mult_13;
 reg [31:0] mult_14;
 reg [31:0] mult_15;
 reg [31:0] mult_16; 
 reg [31:0] result;
 
 
 //This reg is use to do the and operation of number1 and number2[i]
 reg [15:0] and_number = 16'h0000; 
 
 reg [15:0] bcd_to_binary = 16'h0000;
 
/*
 * Here, we declare some signals need to convert to BCD
 *
 *
 */

reg [15:0] bcd_number; 
reg [3:0] thousands;
reg [3:0] hundreds;
reg [3:0] tens;
reg [3:0] ones;

// Internal variable for storing bits
reg [31:0] shift;
integer i;

 
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
	
	//First we have to convert the entries
/*	if(entry_1[3:0] == 4'd0 && entry_2[3:0] == 4'd0) begin
		transformed_entry_1 = entry_1[15:4];
		transformed_entry_2 = entry_2[15:4];
	end */
 
	and_number = (transformed_entry_2[0] == 1'b1) ? 16'hffff : 16'h0000;
	mult_1 = transformed_entry_1 & and_number;
	and_number = (transformed_entry_2[1] == 1'b1) ? 16'hffff: 16'h0000;
	mult_2 = transformed_entry_1 & and_number;
	mult_2 = mult_2 << 1;
	and_number = (transformed_entry_2[2] == 1'b1) ? 16'hffff : 16'h0000;
	mult_3 = transformed_entry_1 & and_number;
	mult_3 = mult_3 << 2;
	and_number = (transformed_entry_2[3] == 1'b1) ? 16'hffff : 16'h0000;
	mult_4 = transformed_entry_1 & and_number;
	mult_4 = mult_4 << 3;
	and_number = (transformed_entry_2[4] == 1'b1) ? 16'hffff : 16'h0000;
	mult_5 = transformed_entry_1 & and_number;
	mult_5 = mult_5 << 4;
	and_number = (transformed_entry_2[5] == 1'b1) ? 16'hffff : 16'h0000;
	mult_6 = transformed_entry_1 & and_number;
	mult_6 = mult_6 << 5;
	and_number = (transformed_entry_2[6] == 1'b1) ? 16'hffff : 16'h0000;
	mult_7 = transformed_entry_1 & and_number;
	mult_7 = mult_7 << 6;
	and_number = (transformed_entry_2[7] == 1'b1) ? 16'hffff : 16'h0000;
	mult_8 = transformed_entry_1 & and_number;
	mult_8 = mult_8 << 7;
	and_number = (transformed_entry_2[8] == 1'b1) ? 16'hffff : 16'h0000;
	mult_9 = transformed_entry_1 & and_number;
	mult_9 = mult_9 << 8;
	and_number = (transformed_entry_2[9] == 1'b1) ? 16'hffff : 16'h0000;
	mult_10 = transformed_entry_1 & and_number;
	mult_10 = mult_10 << 9;
	and_number = (transformed_entry_2[10] == 1'b1) ? 16'hffff : 16'h0000;
	mult_11 = transformed_entry_1 & and_number;
	mult_11= mult_11 << 10;
	and_number = (transformed_entry_2[11] == 1'b1) ? 16'hffff : 16'h0000;
	mult_12 = transformed_entry_1 & and_number;
	mult_12 = mult_12 << 11;
	and_number = (transformed_entry_2[12] == 1'b1) ? 16'hffff : 16'h0000;
	mult_13 = transformed_entry_1 & and_number;
	mult_13 = mult_13 << 12;
	and_number = (transformed_entry_2[13] == 1'b1) ? 16'hffff : 16'h0000;
	mult_14 = transformed_entry_1 & and_number;
	mult_14 = mult_14 << 13;
	and_number = (transformed_entry_2[14] == 1'b1) ? 16'hffff : 16'h0000;
	mult_15 = transformed_entry_1 & and_number;
	mult_15 = mult_15 << 14;
	and_number = (transformed_entry_2[15] == 1'b1) ? 16'hffff : 16'h0000;
	mult_16 = transformed_entry_1 & and_number;
	mult_16 = mult_16 << 15;

	output_1 = mult_1 + mult_2;
	output_1 = output_1 + mult_3;
	output_1 = output_1 + mult_4;
	output_1 = output_1 + mult_5;
	output_1 = output_1 + mult_6;
	output_1 = output_1 + mult_7;
	output_1 = output_1 + mult_8;
	output_1 = output_1 + mult_9;
	output_1 = output_1 + mult_10;
	output_1 = output_1 + mult_11;
	output_1 = output_1 + mult_12;
	output_1 = output_1 + mult_13;
	output_1 = output_1 + mult_14;
	output_1 = output_1 + mult_15;
	output_1 = output_1 + mult_16;
	
	//Convert to bcd
	shift[31:15] = 0;
   shift[15:0] = output_1;
      
    // Loop eight times
    for (i=0; i<16; i=i+1) begin
		 if (shift[19:16] >= 5)
          shift[19:16] = shift[19:16] + 3;
			 
       if (shift[23:20] >= 5)
          shift[23:20] = shift[23:20] + 3;
            
       if (shift[27:24] >= 5)
          shift[27:24] = shift[27:24] + 3;
            
       if (shift[31:28] >= 5)
          shift[31:28] = shift[31:28] + 3;
         
        // Shift entire register left once
        shift = shift << 1;
     end
      
     // Push decimal numbers to output
	  thousands = shift[31:28];
     hundreds = shift[27:24];
     tens     = shift[23:20];
     ones     = shift[19:16];
	  bcd_number = {thousands,hundreds, tens,ones};
	  

	  bcd_to_binary = (bcd_number[15:12] * 7'b1100100) + (bcd_number[11:8] * 4'b1010) + {3'b0, bcd_number[7:4]};	
	  output_1 = bcd_to_binary;
		
	
	
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


endmodule // end multiplier_module