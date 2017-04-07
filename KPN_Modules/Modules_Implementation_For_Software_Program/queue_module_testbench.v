module queue_module_testbench;

/*
 * We define the type of the entries and outputs
 */
reg clk_test;
reg rd_test;
reg wr_test;
reg [15:0] entry_1_test;
wire [15:0] output_1_test;


/*
 * We instantiate the device under test
 * 
 */
	
queue_module #(.BITS_NUMBER(16), .FIFO_ELEMENTS(5), .NUMBER_OF_PRECHARGE_DATA(4)) DUT(.clk(clk_test), .rd(rd_test),
			.wr(wr_test), .entry_1(entry_1_test), .output_1(output_1_test));
						

/*
 * Test vector generator
 * 
 */
 
initial begin

clk_test = 1'b0;
wr_test = 1'b0;
entry_1_test = 16'd0;

#100
rd_test = 1'b1;


end


/*
 * Clock generation
 * 
 */
always
 #100  clk_test =  !clk_test;
 
 
endmodule // end queue_module_testbench