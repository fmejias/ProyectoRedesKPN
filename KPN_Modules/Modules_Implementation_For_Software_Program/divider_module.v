module divider_module (
clk,
entry_1,
entry_2,
output_1
);

/*
 * We define the entries and outputs
 */
 
input clk;
input [15:0] entry_1; //Dividendo
input [15:0] entry_2; //Divisor
output [15:0] output_1; //Cociente


/*
 * We define the type of outputs
 * 
 */
	
 reg [15:0] output_1;


/*
 * We make the divide operation.
 * 
 */

 reg [3:0] counter = 4'b1111 ; //Is use to go over the dividendo
 reg [15:0] dividendo = {16'h0000, entry_1[counter]}; //Represents the dividendo
 reg [15:0] residuo = 16'h0000; //Contains the substract of the dividendo and the divider
 reg already_divide = 1'b0; //Use to know when to concatenate zeros at the cociente

 
 always @(posedge clk)
 begin
 
	if(counter == 4'b0000) //In this part, the division is finished
	begin
		if(dividendo >= entry_2)
			begin
			output_1 = {output_1, 1'b1};
			end
			else
			begin
			output_1 = {output_1, 1'b0};
			end
	end
		
	else
	begin
		
		if(already_divide == 1'b0)
		begin
			if(dividendo >= entry_2)
			begin
			residuo = dividendo - entry_2;
			counter = counter - 1'b1; //Decrement the counter
			dividendo = {residuo, entry_1[counter]};
			output_1 = {output_1, 1'b1}; //Add a 1 to the cociente
			already_divide = 1'b1;
			
			end
			
			else
			begin
			counter = counter - 1'b1;
			dividendo = {dividendo, entry_1[counter]}; //Here I get the dividendo
			end
		
		end
		else
		begin
			if(dividendo >= entry_2)
			begin
			residuo = dividendo - entry_2; //Make the substract between the dividendo and the divisor
			counter = counter - 1'b1; //Decrement the counter
			dividendo = {residuo, entry_1[counter]};
			output_1 = {output_1, 1'b1}; //Add a 1 to the cociente
			end
			
			else
			begin
			counter = counter - 1'b1;
			dividendo = {dividendo, entry_1[counter]}; //Here I get the dividendo
			output_1 = {output_1, 1'b0};
			end
		end
		
	end
		
	  
 end
 

endmodule // end divider_module