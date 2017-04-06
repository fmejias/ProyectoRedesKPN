module multiplier_module (
entry_1,
entry_2,
mult,
reset,
show_mult,
result,
show_result
);

/*
 * We define the type of entries and outputs
 */

input [15:0] entry_1;
input [15:0] entry_2; 
input mult; //This input make the mult operation 
input reset;
input show_mult; //This input make the LCD to show the mult result
output [31:0] result;
output show_result;


/*
 * We make the mult operation.
 * Also, we enable the show_result signal
 */

 reg [15:0] first_entry;
 reg [15:0] second_entry;
 reg [31:0] result;
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
 reg [15:0] and_number; //This reg is use to do the and operation of number1 and number2[i]
 reg show_result;
 reg number1_written;
 reg number2_written;
 
 always @(*)
 begin
  if(reset)
  begin
   first_entry = 16'h0000;
	second_entry = 16'h0000;
	and_number = 16'h0000;
	number1_written = 1'b0;
	number2_written = 1'b0;
	result = 32'h00000000;
	show_result = 1'b0;
  end
  else
  begin
   if(mult)
	 begin
	  if(number1_written == 1'b0)
	  begin
	   number1_written = 1'b1;
		first_entry = entry_1;
	  end
	 end
	else
	 begin
	  if(number2_written == 1'b0)
	  begin
	   number2_written = 1'b1;
		second_entry = entry_2;
	  end
	  else if(show_mult == 1'b1)
	  begin
		and_number = (second_entry[0] == 1'b1) ? 16'hffff : 16'h0000;
		mult_1 = first_entry & and_number;
		and_number = (second_entry[1] == 1'b1) ? 16'hffff: 16'h0000;
		mult_2 = first_entry & and_number;
		mult_2 = mult_2 << 1;
		and_number = (second_entry[2] == 1'b1) ? 16'hffff : 16'h0000;
		mult_3 = first_entry & and_number;
		mult_3 = mult_3 << 2;
		and_number = (second_entry[3] == 1'b1) ? 16'hffff : 16'h0000;
		mult_4 = first_entry & and_number;
		mult_4 = mult_4 << 3;
		and_number = (second_entry[4] == 1'b1) ? 16'hffff : 16'h0000;
		mult_5 = first_entry & and_number;
		mult_5 = mult_5 << 4;
		and_number = (second_entry[5] == 1'b1) ? 16'hffff : 16'h0000;
		mult_6 = first_entry & and_number;
		mult_6 = mult_6 << 5;
		and_number = (second_entry[6] == 1'b1) ? 16'hffff : 16'h0000;
		mult_7 = first_entry & and_number;
		mult_7 = mult_7 << 6;
		and_number = (second_entry[7] == 1'b1) ? 16'hffff : 16'h0000;
		mult_8 = first_entry & and_number;
		mult_8 = mult_8 << 7;
		and_number = (second_entry[8] == 1'b1) ? 16'hffff : 16'h0000;
		mult_9 = first_entry & and_number;
		mult_9 = mult_9 << 8;
		and_number = (second_entry[9] == 1'b1) ? 16'hffff : 16'h0000;
		mult_10 = first_entry & and_number;
		mult_10 = mult_10 << 9;
		and_number = (second_entry[10] == 1'b1) ? 16'hffff : 16'h0000;
		mult_11 = first_entry & and_number;
		mult_11= mult_11 << 10;
		and_number = (second_entry[11] == 1'b1) ? 16'hffff : 16'h0000;
		mult_12 = first_entry & and_number;
		mult_12 = mult_12 << 11;
		and_number = (second_entry[12] == 1'b1) ? 16'hffff : 16'h0000;
		mult_13 = first_entry & and_number;
		mult_13 = mult_13 << 12;
		and_number = (second_entry[13] == 1'b1) ? 16'hffff : 16'h0000;
		mult_14 = first_entry & and_number;
		mult_14 = mult_14 << 13;
		and_number = (second_entry[14] == 1'b1) ? 16'hffff : 16'h0000;
		mult_15 = first_entry & and_number;
		mult_15 = mult_15 << 14;
		and_number = (second_entry[15] == 1'b1) ? 16'hffff : 16'h0000;
		mult_16 = first_entry & and_number;
		mult_16 = mult_16 << 15;
	
	   result = mult_1 + mult_2;
		result = result + mult_3;
		result = result + mult_4;
		result = result + mult_5;
		result = result + mult_6;
		result = result + mult_7;
		result = result + mult_8;
		result = result + mult_9;
		result = result + mult_10;
		result = result + mult_11;
		result = result + mult_12;
		result = result + mult_13;
		result = result + mult_14;
		result = result + mult_15;
		result = result + mult_16; 
		show_result = 1'b1;
	  end
	 end
	 
  end
  
 end


endmodule // end multiplier_module