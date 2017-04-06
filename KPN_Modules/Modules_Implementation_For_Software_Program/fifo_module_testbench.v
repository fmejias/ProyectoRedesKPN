module fifo_module_testbench;

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
	
fifo_module #(.BITS_NUMBER(16), .FIFO_ELEMENTS(5)) DUT(.clk(clk_test), .rd(rd_test),
			.wr(wr_test), .entry_1(entry_1_test), .output_1(output_1_test));
						

/*
 * Test vector generator
 * 
 */
 
initial begin

clk_test = 1'b0;

entry_1_test = 16'd0;

#100
entry_1_test = 16'd10;
wr_test = 1'b1;
rd_test = 1'b1;

#100
wr_test = 1'b0;
rd_test = 1'b0;

#100
entry_1_test = 16'd20;
wr_test = 1'b1;
rd_test = 1'b1;

#100
wr_test = 1'b0;
rd_test = 1'b0;

#100
entry_1_test = 16'd30;
wr_test = 1'b1;
rd_test = 1'b1;

#100
wr_test = 1'b0;
rd_test = 1'b0;

#100
entry_1_test = 16'd40;
wr_test = 1'b1;
rd_test = 1'b1;

end


/*
 * Clock generation
 * 
 */
always
 #100  clk_test =  !clk_test;
 
 
endmodule // end fifo_module_testbench