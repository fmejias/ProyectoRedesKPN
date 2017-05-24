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
wire [15:0] rd_adder_module_3;
wire [15:0] wr_adder_module_3;
wire [15:0] rd_multiplier_module_5;
wire [15:0] wr_multiplier_module_5;
wire [15:0] wr_queue_module_1;
wire [15:0] wr_queue_module_2;
wire [15:0] rd_split_module_4;
wire [15:0] wr_split_module_4;
wire [15:0] output_fifo_module_7_1;
wire [15:0] output_fifo_module_8_1;
wire [15:0] output_fifo_module_9_1;
wire [15:0] output_fifo_module_10_1;
wire [15:0] output_fifo_module_11_1;
wire [15:0] output_adder_module_3_1;
wire [15:0] output_multiplier_module_5_1;
wire [15:0] output_queue_module_1_1;
wire [15:0] output_queue_module_2_1;
wire [15:0] output_fifo_module_6_1;
wire [15:0] output_split_module_4_1;
wire [15:0] output_split_module_4_2;

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
 * This is an instance of the fifo module
 */
fifo_module fifo_module_inst7(.clk(kpn_clk), .rd(rd_split_module_4), .wr(wr_adder_module_3), .entry_1(output_adder_module_3_1), .output_1(output_fifo_module_7_1));

/*
 * This is an instance of the fifo module
 */
fifo_module fifo_module_inst8(.clk(kpn_clk), .rd(rd_multiplier_module_5), .wr(wr_split_module_4), .entry_1(output_split_module_4_1), .output_1(output_fifo_module_8_1));

/*
 * This is an instance of the fifo module
 */
fifo_module fifo_module_inst9(.clk(kpn_clk), .rd(rd_multiplier_module_5), .wr(wr_split_module_4), .entry_1(output_split_module_4_2), .output_1(output_fifo_module_9_1));

/*
 * This is an instance of the fifo module
 */
fifo_module fifo_module_inst10(.clk(kpn_clk), .rd(rd_adder_module_3), .wr(wr_queue_module_1), .entry_1(output_queue_module_1_1), .output_1(output_fifo_module_10_1));

/*
 * This is an instance of the fifo module
 */
fifo_module fifo_module_inst11(.clk(kpn_clk), .rd(rd_adder_module_3), .wr(wr_queue_module_2), .entry_1(output_queue_module_2_1), .output_1(output_fifo_module_11_1));

/*
 * This is an instance of the adder module
 */
adder_module adder_module_inst_3(.clk(kpn_clk), .rd(rd_adder_module_3), .wr(wr_adder_module_3), .entry_1(output_fifo_module_10_1), .entry_2(output_fifo_module_11_1), .output_1(output_adder_module_3_1));

/*
 * This is an instance of the multiplier module
 */
multiplier_module multiplier_module_inst5(.clk(kpn_clk), .rd(rd_multiplier_module_5), .wr(wr_multiplier_module_5), .entry_1(output_fifo_module_8_1), .entry_2(output_fifo_module_9_1), .output_1(output_multiplier_module_5_1));

/*
 * This is an instance of the queue module
 */
queue_module1 queue_module_inst1(.clk(kpn_clk), .wr(wr_queue_module_1), .output_1(output_queue_module_1_1));

/*
 * This is an instance of the queue module
 */
queue_module2 queue_module_inst2(.clk(kpn_clk), .wr(wr_queue_module_2), .output_1(output_queue_module_2_1));

/*
 * This is an instance of the bcd_converter module
 */
bcd_converter bcd_converter_inst(.clk(kpn_clk), .binary_number(output_fifo_module_6_1), .bcd_number(bcd_output));

/*
 * This is an instance of the fifo module
 */
lcd_fifo fifo_module_inst6(.clk(kpn_clk), .rd(lcd_rd), .wr(wr_multiplier_module_5), .entry_1(output_multiplier_module_5_1), .output_1(output_fifo_module_6_1));

/*
 * This is an instance of the split module
 */
split_module split_module_inst4(.clk(kpn_clk), .rd(rd_split_module_4), .wr(wr_split_module_4), .entry_1(output_fifo_module_7_1), .output_1(output_split_module_4_1), .output_2(output_split_module_4_2));

endmodule
