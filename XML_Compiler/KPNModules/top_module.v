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
wire [15:0] output_adder_module_1_1;
wire [15:0] output_subtractor_module_1_1;
wire [15:0] output_adder_module_2_1;
wire [15:0] output_adder_module_3_1;
wire [15:0] output_subtractor_module_2_1;
wire [15:0] output_split_module_1_1;
wire [15:0] output_split_module_1_2;

/*
 * Here, we instantiate the modules
 */
/*
 * This is an instance of the adder module
 */
adder_module adder_module_inst_1 (.clk(clk), .entry_1(output_ fifo_module_1_1 ),.entry_2(output_ fifo_module_2_1 ), .output_1(output_adder_module_1_1);

/*
 * This is an instance of the subtractor module
 */
subtractor_module subtractor_module_inst_1 (.clk(clk), .entry_1(output_ adder_module_1_1 ),.entry_2(output_ adder_module_1_1 ), .output_1(output_subtractor_module_1_1);

/*
 * This is an instance of the adder module
 */
adder_module adder_module_inst_2 (.clk(clk), .entry_1(output_ subtractor_module_1_1 ),.entry_2(output_ subtractor_module_1_1 ), .output_1(output_adder_module_2_1);

/*
 * This is an instance of the adder module
 */
adder_module adder_module_inst_3 (.clk(clk), .entry_1(output_ adder_module_2_1 ),.entry_2(output_ adder_module_2_1 ), .output_1(output_adder_module_3_1);

/*
 * This is an instance of the subtractor module
 */
subtractor_module subtractor_module_inst_2 (.clk(clk), .entry_1(output_ split_module_1_1 ),.entry_2(output_ split_module_1_2 ), .output_1(output_subtractor_module_2_1);

/*
 * This is an instance of the split module
 */
split_module split_module_inst1(.clk(clk), .entry_1(output_ adder_module_2_1 ),.output_1(output_split_module_1_1).output_2(output_split_module_1_2);

