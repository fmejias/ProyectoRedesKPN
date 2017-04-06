module delay_module_testbench;

/*
 * We define the type of the entries and outputs
 */
reg clk_test;
reg [15:0] entry_1_test;
wire [15:0] output_1_test;


/*
 * We instantiate the device under test
 * The DELAY_NUMBER is the parameter of the module
 * 
 */
	
delay_module #(.DELAY_NUMBER(4)) DUT(.clk(clk_test), 
					.entry_1(entry_1_test), .output_1(output_1_test));
						

/*
 * Test vector generator
 * 
 */
 
initial begin

clk_test = 1'b0;
entry_1_test = 16'd1500;

end


/*
 * Clock generation
 * 
 */
always
 #100  clk_test =  !clk_test;
 
 

endmodule // end delay_module_testbench