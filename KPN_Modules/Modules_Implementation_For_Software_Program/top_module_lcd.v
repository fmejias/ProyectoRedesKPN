module top_module_lcd (
clk,
rs,
rw,
on,
en,
lcd_data
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
 wire fifo_3_rd;
 wire adder_1_rd;
 wire adder_1_wr;
 wire [15:0] adder_1_output;

 

/*
 * Here, we instantiate the modules
 *
 *
 */
 
 //This is the instance of the clock divider module
 clock_divider clk_inst(.clk_in(clk), .clk_out(kpn_clk));
 
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
 fifo_module fifo_3_inst(.clk(kpn_clk), .rd(lcd_rd),
 .wr(adder_1_wr), .entry_1(adder_1_output), .output_1(fifo_3_output));
 
 //This is the adder
 adder_module adder_inst(.clk(kpn_clk), .rd(adder_1_rd), .wr(adder_1_wr), .entry_1(fifo_1_output), .entry_2(fifo_2_output), .output_1(adder_1_output));

 //This is an instance of the LCD module
 lcd_module write_to_lcd_inst(.clock(kpn_clk), .entry_1(fifo_3_output), .rs(rs), .rw(rw), .on(on), .enable(en), .lcd_data(lcd_data) , .rd(lcd_rd));
 
 
endmodule