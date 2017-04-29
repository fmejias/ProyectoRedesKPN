module adder_module_testbench;

/*
 * We define the type of the entries and outputs
 */
reg clk_test;
reg [15:0] entry_1_test;
reg [15:0] entry_2_test;
wire [15:0] output_1_test;
wire rd_test;
wire wr_test;


/*
 * We instantiate the device under test
 * 
 */
	
adder_module DUT(.clk(clk_test), .rd(rd_test), .wr(wr_test), .entry_1(entry_1_test), .entry_2(entry_2_test), 
						.output_1(output_1_test));
						

/*
 * Test vector generator
 * 
 */
 
initial begin

clk_test = 1'b0;
entry_1_test = 16'h0000; //0,0
entry_2_test = 16'h0000; //0,0

#100
entry_1_test = 16'h0047; //4,7
entry_2_test = 16'h0065; //6,5

#200
entry_1_test = 16'h0053; //5,3
entry_2_test = 16'h00C7; //12,7

#200
entry_1_test = 16'h0C84; //200,4
entry_2_test = 16'h0965; //150,5

$stop;

end


/*
 * Clock generation
 * 
 */
always
 #100  clk_test =  !clk_test;
 
 

endmodule // end adder_module_testbench