module top_module_display (
clk,
hex_4,
hex_3,
hex_2,
hex_1,
hex_0
);

/*
 * We define the type of entries and outputs
 */

input clk;
output [6:0] hex_4;
output [6:0] hex_3;
output [6:0] hex_2;
output [6:0] hex_1;
output [6:0] hex_0;


/*
 * Here, we declare some signals need it to pass information between modules
 *
 *
 */

 wire kpn_clk;
 wire queue_1_wr;
 wire[15:0] queue_1_output;
 wire[15:0] queue_2_output;
 wire queue_2_wr;
 wire fifo_rd;
 wire[15:0] fifo_1_output;
 wire[15:0] fifo_2_output;
 wire[15:0] fifo_3_output;
 wire adder_1_rd;
 wire adder_1_wr;
 wire subtractor_1_rd;
 wire subtractor_1_wr;
 wire [15:0] adder_output_1;
 wire [15:0] subtractor_output_1;
 wire [15:0] bcd_output;
 

/*
 * Here, we instantiate the modules
 *
 *
 */
 
 //This is the instance of the clock divider module
 clock_divider clk_inst(.clk_in(clk), .clk_out(kpn_clk));
 
 //This is the queue1
 queue_module queue_1_inst(.clk(clk), .wr(queue_1_wr), .output_1(queue_1_output));
 
 //This is the queue2
 queue_module queue_2_inst(.clk(clk), .wr(queue_2_wr), .output_1(queue_2_output));
 
 //This is the fifo1
 fifo_module fifo_1_inst(.clk(clk), .rd(adder_1_rd),
 .wr(queue_1_wr), .entry_1(queue_1_output), .output_1(fifo_1_output));
 
 //This is the fifo2
 fifo_module fifo_2_inst(.clk(clk), .rd(adder_1_rd),
 .wr(queue_2_wr), .entry_1(queue_2_output), .output_1(fifo_2_output));
 
 //This is the adder
 adder_module adder_inst(.clk(clk), .rd(adder_1_rd), .wr(adder_1_wr), .entry_1(fifo_1_output), .entry_2(fifo_2_output), .output_1(adder_output_1));
 
 //This is the fifo3
 fifo_module fifo_3_inst(.clk(clk), .rd(subtractor_1_rd),
 .wr(adder_1_wr), .entry_1(adder_output_1), .output_1(fifo_3_output));
 
 //This is the subtractor
 subtractor_module subtractor_inst(.clk(clk), .rd(subtractor_1_rd), .wr(subtractor_1_wr), .entry_1(fifo_3_output), .entry_2(16'h0003), .output_1(subtractor_output_1));

 //This is the first instance of the bcd_converter
 bcd_converter bcd_converter_inst(.clk(clk), .binary_number(subtractor_output_1), .bcd_number(bcd_output));
 
 //This is the instance of the display module
 write_to_display display_inst(.clk(clk), .entry_1(bcd_output), .hex_4(hex_4), .hex_3(hex_3), .hex_2(hex_2), 
 .hex_1(hex_1), .hex_0(hex_0));
 
endmodule