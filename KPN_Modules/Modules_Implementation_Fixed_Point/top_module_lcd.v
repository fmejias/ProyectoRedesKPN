module top_module_lcd (
clk,
rs,
rw,
on,
en,
lcd_data,
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
output rs;
output rw;
output on;
output en;
output [7:0] lcd_data;
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
 wire lcd_rd;
 wire[15:0] fifo_1_output;
 wire[15:0] fifo_2_output;
 wire[15:0] fifo_3_output;
 wire[15:0] fifo_4_output;
 wire[15:0] fifo_5_output;
 wire[15:0] fifo_6_output;
 wire fifo_3_rd;
 wire adder_1_rd;
 wire adder_1_wr;
 wire adder_2_rd;
 wire adder_2_wr;
 wire split_1_rd;
 wire split_1_wr;
 wire [15:0] adder_1_output;
 wire [15:0] adder_2_output;
 wire [15:0] split_1_output_1;
 wire [15:0] split_1_output_2;
 wire [15:0] bcd_output;

 

/*
 * Here, we instantiate the modules
 *
 *
 */
 
 //This is the instance of the clock divider module
 clock_divider_module clk_inst(.clk_in(clk), .clk_out(kpn_clk));
 
 //This is the queue1
 queue_module queue_1_inst(.clk(kpn_clk), .wr(queue_1_wr), .output_1(queue_1_output));
 
 //This is the queue2
 queue_module queue_2_inst(.clk(kpn_clk), .wr(queue_2_wr), .output_1(queue_2_output));
 
 //This is the fifo1
 fifo_module fifo_1_inst(.clk(kpn_clk), .rd(adder_1_rd),
 .wr(queue_1_wr), .entry_1(queue_1_output), .output_1(fifo_1_output));
 
 //This is the fifo2
 fifo_module fifo_2_inst(.clk(kpn_clk), .rd(adder_1_rd),
 .wr(queue_2_wr), .entry_1(queue_2_output), .output_1(fifo_2_output));
 
 //This is the fifo3
 fifo_module fifo_3_inst(.clk(kpn_clk), .rd(adder_2_rd),
 .wr(adder_1_wr), .entry_1(adder_1_output), .output_1(fifo_3_output));
 
 //This is the fifo4
 lcd_fifo fifo_4_inst(.clk(kpn_clk), .rd(lcd_rd),
 .wr(adder_2_wr), .entry_1(adder_2_output), .output_1(fifo_4_output));
 
 //This is the adder 1
 adder_module adder_1_inst(.clk(kpn_clk), .rd(adder_1_rd), 
 .wr(adder_1_wr), .entry_1(fifo_1_output), .entry_2(fifo_2_output), 
 .output_1(adder_1_output));
 
 //This is the adder 2
 adder_module adder_2_inst(.clk(kpn_clk), .rd(adder_2_rd), 
 .wr(adder_2_wr), .entry_1(fifo_3_output), .entry_2(fifo_3_output), 
 .output_1(adder_2_output));

 
 //This is the first instance of the bcd_converter
 bcd_converter bcd_converter_inst(.clk(kpn_clk), .binary_number(fifo_4_output), .bcd_number(bcd_output));
 
 //This is an instance of the LCD module
 lcd_module write_to_lcd_inst(.clock(kpn_clk), .entry_1(bcd_output), .rs(rs), .rw(rw), .on(on), .enable(en), .lcd_data(lcd_data) , .rd(lcd_rd));
 
 //This is the instance of the display module
 write_to_display display_inst(.clk(kpn_clk), .entry_1(bcd_output), .hex_4(hex_4), .hex_3(hex_3), .hex_2(hex_2), 
 .hex_1(hex_1), .hex_0(hex_0));
 
endmodule