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

end



/*
 * Clock generation
 * 
 */
always
 #100  clk_test =  !clk_test;
 
 

endmodule // end top_module_testbench