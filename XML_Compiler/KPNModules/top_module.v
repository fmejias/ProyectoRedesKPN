module top_module (
clk,
output_1
);


/*
 * We define the type of entries and outputs
 */
input clk;
output [15:0] output_1;


/*
 * Here, we declare some signals need it to pass information between modules
 */
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
 * This is an instance of the fifo module
 */
fifo_module fifo_module_inst3(.clk(clk), .rd(rd__module_), .wr(wr_adder_module_1), .entry_1(output_adder_module_1_1 ), .output_1(output_fifo_module_3_1));

