module queue_module_testbench;

/*
 * We define the type of the entries and outputs
 */
reg clk_test;
reg rd_test;
wire [15:0] output_1_test;


/*
 * We instantiate the device under test
 * 
 */
	
queue_module #(.BITS_NUMBER(16), .FIFO_ELEMENTS(5), .NUMBER_OF_PRECHARGE_DATA(4)) DUT(.clk(clk_test),.rd(rd_test),
			.output_1(output_1_test));
						

/*
 * Test vector generator
 * 
 */
 
initial begin

clk_test = 1'b0;
rd_test = 1'b0;

#100
rd_test = 1'b1;

#100
rd_test = 1'b0;
end


/*
 * Clock generation
 * 
 */
always
begin
 #100  
 clk_test =  !clk_test;
 //rd_test =  !rd_test;
 end
 
endmodule // end queue_module_testbench