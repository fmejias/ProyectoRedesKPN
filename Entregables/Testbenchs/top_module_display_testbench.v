module top_module_display_testbench;

/*
 * We define the type of the entries and outputs
 */
reg clk_test;
reg [3:0]i;
wire [6:0] hex_4;
wire [6:0] hex_3;
wire [6:0] hex_2;
wire [6:0] hex_1;
wire [6:0] hex_0;


/*
 * We instantiate the device under test
 * 
 */
	
top_module_display DUT(.clk(clk_test), .hex_4(hex_4), .hex_3(hex_3), .hex_2(hex_2),
								.hex_1(hex_1), .hex_0(hex_0));
						

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
 
 

endmodule // end top_module_display_testbench