module top_module (
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
 */
wire kpn_clk;
wire [15:0] bcd_output;
wire lcd_rd;
wire [15:0] wr_queue_module_1;
wire [15:0] wr_queue_module_2;
wire [15:0] rd_adder_module_1;
wire [15:0] wr_adder_module_1;
wire [15:0] output_queue_module_1_1;
wire [15:0] output_queue_module_2_1;
wire [15:0] output_fifo_module_1_1;
wire [15:0] output_fifo_module_2_1;
wire [15:0] output_adder_module_1_1;
wire [15:0] output_fifo_module_3_1;

/*
 * Here, we instantiate the modules
 */

/*
 * This is an instance of the clock_divider module
 */
clock_divider_module clk_inst(.clk_in(clk), .clk_out(kpn_clk));

/*
 * This is an instance of the display module
 */
write_to_display display_inst(.clk(kpn_clk), .entry_1(bcd_output), .hex_4(hex_4), .hex_3(hex_3), .hex_2(hex_2), .hex_1(hex_1), .hex_0(hex_0));

/*
 * This is an instance of the LCD module
 */
lcd_module write_to_lcd_inst(.clock(kpn_clk), .entry_1(bcd_output), .rs(rs), .rw(rw), .on(on), .enable(en), .lcd_data(lcd_data) , .rd(lcd_rd));

/*
 * This is an instance of the queue module
 */
queue_module1 queue_module_inst1(.clk(clk), .wr(wr_queue_module_1), .output_1(output_queue_module_1_1));

/*
 * This is an instance of the queue module
 */
queue_module2 queue_module_inst2(.clk(clk), .wr(wr_queue_module_2), .output_1(output_queue_module_2_1));

/*
 * This is an instance of the fifo module
 */
fifo_module fifo_module_inst1(.clk(clk), .rd(rd_adder_module_1), .wr(wr_queue_module_1), .entry_1(output_queue_module_1_1 ), .output_1(output_fifo_module_1_1));

/*
 * This is an instance of the fifo module
 */
fifo_module fifo_module_inst2(.clk(clk), .rd(rd_adder_module_1), .wr(wr_queue_module_2), .entry_1(output_queue_module_2_1 ), .output_1(output_fifo_module_2_1));

/*
 * This is an instance of the adder module
 */
adder_module adder_module_inst_1(.clk(clk), .rd(rd_adder_module_1), .wr(wr_adder_module_1), .entry_1(output_fifo_module_1_1 ), .entry_2(output_fifo_module_2_1 ), .output_1(output_adder_module_1_1));

/*
 * This is an instance of the bcd_converter module
 */
bcd_converter bcd_converter_inst(.clk(kpn_clk), .binary_number(output_fifo_module_3_1), .bcd_number(bcd_output));

/*
 * This is an instance of the fifo module
 */
lcd_fifo fifo_module_inst3(.clk(clk), .rd(lcd_rd), .wr(wr_adder_module_1), .entry_1(output_adder_module_1_1 ), .output_1(output_fifo_module_3_1));

