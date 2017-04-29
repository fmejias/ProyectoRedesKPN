module multiplier_module_testbench;

/*
 * We define the type of the entries and outputs
 */
reg clk_test;
reg [15:0] entry_1_test;
reg [15:0] entry_2_test;
wire [31:0] output_1_test;
wire rd_test;
wire wr_test;

/*
 * We instantiate the device under test
 * 
 */
	
multiplier_module DUT(.clk(clk_test), .rd(rd_test), .wr(wr_test), .entry_1(entry_1_test), .entry_2(entry_2_test), 
						.output_1(output_1_test));
						

/*
 * Test vector generator
 * 
 */
 
initial begin

clk_test = 1'b0;
entry_1_test = 16'h0000;
entry_2_test = 16'h0000;

#100
entry_1_test = 16'd20;
entry_2_test = 16'd20;

#200
entry_1_test = 16'd5;
entry_2_test = 16'd5;

#200
entry_1_test = 16'd10;
entry_2_test = 16'd9;

end


/*
 * Clock generation
 * 
 */
always
 #100  clk_test =  !clk_test;
 
 

endmodule // end multiplier_module_testbench