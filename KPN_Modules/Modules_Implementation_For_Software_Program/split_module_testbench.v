module split_module_testbench;

/*
 * We define the type of the entries and outputs
 */
reg clk_test;
reg [15:0] entry_1_test;
wire [15:0] output_1_test;
wire [15:0] output_2_test;


/*
 * We instantiate the device under test
 * 
 */
	
split_module DUT(.clk(clk_test), .entry_1(entry_1_test), .output_1(output_1_test), 
						.output_2(output_2_test));
						

/*
 * Test vector generator
 * 
 */
 
initial begin

clk_test = 1'b0;
entry_1_test = 16'h0000;

#100
entry_1_test = 16'd10;

#200
entry_1_test = 16'd50;

#200
entry_1_test = 16'd90;

end


/*
 * Clock generation
 * 
 */
always
 #100  clk_test =  !clk_test;
 
 

endmodule // end split_module_testbench