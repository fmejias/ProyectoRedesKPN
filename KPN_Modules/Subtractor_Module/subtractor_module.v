module subtractor_module (
entry_1,
entry_2,
subtract,
reset,
show_subtract,
result,
show_result
);

/*
 * We define the type of entries and outputs
 */

input [15:0] entry_1;
input [15:0] entry_2; 
input subtract; //This input make the sub operation 
input reset;
input show_subtract; //This input make the LCD to show the subtract result
output [15:0] result;
output show_result;


/*
 * We make the subtract operation.
 * Also, we enable the show_result signal
 */

 reg [15:0] first_entry;
 reg [15:0] second_entry;
 reg [15:0] result;
 reg show_result;
 reg number1_written;
 reg number2_written;
 
 always @(*)
 begin
  if(reset)
  begin
   first_entry = 16'h0000;
	second_entry = 16'h0000;
	number1_written = 1'b0;
	number2_written = 1'b0;
	result = 16'h0000;
	show_result = 1'b0;
  end
  else
  begin
   if(subtract)
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
	  else if(show_subtract == 1'b1)
	  begin
	   result = first_entry - second_entry;
		show_result = 1'b1;
	  end
	 end
	 
  end
  
 end


endmodule // end adder_module