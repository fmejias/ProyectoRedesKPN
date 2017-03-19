module divider_module (
entry_1,
entry_2,
clk,
divide,
reset,
show_division,
result,
show_result
);

/*
 * We define the type of entries and outputs
 */
input clk;
input [15:0] entry_1; //Dividendo original 
input [15:0] entry_2; //Divisor
input divide; //This input save the entry_1 
input reset;
input show_division; //This input make the LCD to show the divide result
output [15:0] result;
output show_result;


/*
 * We make the add operation.
 * Also, we enable the show_result signal
 */

 reg [15:0] first_entry;
 reg [15:0] second_entry;
 reg [15:0] result; //This register is going to be the cociente
 reg [3:0] counter; //Is use to go over the dividendo
 reg [15:0] dividendo; //Represents the dividendo
 reg [15:0] coeficiente;
 reg show_result;
 reg number1_written;
 reg number2_written;
 reg make_division; //This new register indicates when to start making the division
 reg already_divide; //Use to know when to concatenate zeros at the cociente

 
 always @(posedge clk)
 begin
  if(reset)
  begin
   first_entry = 16'h0000;
	second_entry = 16'h0000;
	number1_written = 1'b0;
	number2_written = 1'b0;
	result = 16'h0000;
	show_result = 1'b0;
	counter = 4'b1111;
	dividendo = 16'h0000;
	make_division = 1'b0;
	already_divide = 1'b0;
  end
  else
  begin
   if(divide == 1'b1)
	 begin 
	  if(number1_written == 1'b0)
	  begin
	   first_entry = entry_1;
	   number1_written = 1'b1;
	  end
	 end
	else if(divide == 1'b0)
	 begin
	  if(number2_written == 1'b0)
	  begin
	   second_entry = entry_2;
	   number2_written = 1'b1;
		dividendo = {dividendo, first_entry[counter]};
	  end
	  else if(show_division == 1'b1 && show_result == 1'b0)
	  begin
	   
		if(counter == 4'b0000) //In this part, the division is finished
		begin
		//	dividendo = {dividendo[14:0], first_entry[counter]}; //Here I get the dividendo
			if(dividendo >= second_entry)
				begin
		//		dividendo = dividendo - second_entry; //Make the substract between the dividendo and the divisor
		//		result = {result[14:0], 1'b1}; //Add a 1 to the cociente
				show_result = 1'b1;
				end
				
				else
				begin
			//	result = {result[14:0], 1'b0};
				show_result = 1'b1;
				end
		end
		
		else
		begin
			
			if(already_divide == 1'b0)
			begin
				if(dividendo >= second_entry)
				begin
				result = dividendo;
		//		dividendo = dividendo - second_entry; //Make the substract between the dividendo and the divisor
				counter = counter - 1'b1; //Decrement the counter
		//		result = {result[14:0], 1'b1}; //Add a 1 to the cociente
				
				already_divide = 1'b1;
				end
				
				else
				begin
				counter = counter - 1'b1;
				dividendo = {dividendo, first_entry[counter]}; //Here I get the dividendo
				end
			
			end
			else
			begin
				if(dividendo >= second_entry)
				begin
		//		dividendo = dividendo - second_entry; //Make the substract between the dividendo and the divisor
				counter = counter - 1'b1; //Decrement the counter
			//	result = {result[14:0], 1'b1}; //Add a 1 to the cociente
			//	result <= 16'h00ff;
				end
				
				else
				begin
				counter = counter - 1'b1;
			//	dividendo = {dividendo[14:0], first_entry[counter]}; //Here I get the dividendo
			//	result = {result[14:0], 1'b0};
				end
			end
			
		end
		
	  end
	  
	 end
	 
  end
  
 end
 
 
 
 
 
/*always @(*)
 begin
	if(reset)
	begin
		result <= 16'h0000;
		show_result = 1'b0;
		counter = 4'b1111;
		dividendo <= 16'h0000;
		make_division = 1'b0;
		already_divide = 1'b0;
		coeficiente = 16'h0000;
	end
	else if(show_division == 1'b1 && make_division == 1'b0 && show_result == 1'b0 && number2_written == 1'b1)
	  begin
		make_division = 1'b1; //This register indicates to start the division
	//	dividendo <= {dividendo[14:0], entry_1[counter]};
	  end
	  
	else if(make_division == 1'b1)
	begin
		if(counter == 4'b0000) //In this part, the division is finished
		begin
		//	dividendo = {dividendo[14:0], entry_1[counter]}; //Here I get the dividendo
			if(dividendo >= second_entry)
				begin
		//		dividendo = dividendo - entry_2; //Make the substract between the dividendo and the divisor
		//		result = {result[14:0], 1'b1}; //Add a 1 to the cociente
			
				already_divide = 1'b1;
		//		result = 16'h00f1;
				show_result = 1'b1;
				make_division = 1'b0;
				
				end
				
				else
				begin
			//	result = {result[14:0], 1'b0};
				show_result = 1'b1;
				make_division = 1'b0;
				end
		end
		
		else
		begin
			
			if(already_divide == 1'b0)
			begin
				if(dividendo >= second_entry)
				begin
		//		dividendo = dividendo - entry_2; //Make the substract between the dividendo and the divisor
				counter = counter - 1'b1; //Decrement the counter
		//		result = {result[14:0], 1'b1}; //Add a 1 to the cociente
				result <= second_entry;
				already_divide = 1'b1;
				end
				
				else
				begin
				counter = counter - 1'b1;
		//		dividendo <= {dividendo[14:0], first_entry[counter]}; //Here I get the dividendo
				end
			
			end
			else
			begin
				if(dividendo >= second_entry)
				begin
		//		dividendo = dividendo - entry_2; //Make the substract between the dividendo and the divisor
				counter = counter - 1'b1; //Decrement the counter
			//	result = {result[14:0], 1'b1}; //Add a 1 to the cociente
			//	result <= 16'h00ff;
				already_divide = 1'b1;
				end
				
				else
				begin
				counter = counter - 1'b1;
			//	dividendo = {dividendo[14:0], first_entry[counter]}; //Here I get the dividendo
			//	result = {result[14:0], 1'b0};
				end
			end
			
		end
	end
	
 end */


endmodule // end divider_module