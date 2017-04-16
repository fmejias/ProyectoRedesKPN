module top_module_testbench;

/*
 * We define the type of the entries and outputs
 */
reg clk_test;
reg [3:0]i;
wire [15:0] output_1_test;


/*
 * We instantiate the device under test
 * 
 */
	
top_module DUT(.clk(clk_test), .output_1(output_1_test));
						

/*
 * Test vector generator
 * 
 */
 
initial begin

clk_test = 1'b0;
i = 4'b0000;

#4000
i = 4'b1111;
end


/*
 * Clock generation
 * 
 */
always
begin
 #100
if(i < 4'b1111)
begin 
clk_test =  !clk_test;
end
else
clk_test = 1'b0;
 
end
 
 

endmodule // end top_module_testbench