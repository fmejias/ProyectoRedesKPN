module top_module (
clock,
select_entry,
select_module,
enable_entry,
hex_7,
hex_6,
hex_5,
hex_4,
hex_3,
hex_2,
hex_1,
hex_0
);

/*
 * We define the type of entries and outputs
 */

input clock; 
input select_entry;
input [4:0] select_module;
input enable_entry;
output [6:0] hex_7;
output [6:0] hex_6;
output [6:0] hex_5;
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

 wire display_clock;
 wire [15:0] data_1_adder_1;
 wire [15:0] data_2_adder_1;
 wire [15:0] data_1_subtractor_1;
 wire [15:0] data_2_subtractor_1;
 wire [15:0] bcd_number_data_1_adder_1;
 wire [15:0] bcd_number_data_2_adder_1;
 wire [15:0] bcd_number_data_1_subtractor_1;
 wire [15:0] bcd_number_data_2_subtractor_1;
 wire [15:0] result;
 wire entry_2_finished; //This is use to show the result of the adder
 
 

/*
 * Here, we instantiate the modules
 *
 *
 */
 
 //This is the first instance of the bcd_converter
 bcd_converter bcd_converter1_inst(.binary_number(data_1_adder_1), .bcd_number(bcd_number_data_1_adder_1));
 
 //This is the first instance of the bcd_converter
 bcd_converter bcd_converter2_inst(.binary_number(data_2_adder_1), .bcd_number(bcd_number_data_2_adder_1));
 
 //This is the first instance of the bcd_converter
 bcd_converter bcd_converter3_inst(.binary_number(data_1_subtractor_1), .bcd_number(bcd_number_data_1_subtractor_1));
 
 //This is the first instance of the bcd_converter
 bcd_converter bcd_converter4_inst(.binary_number(data_2_subtractor_1), .bcd_number(bcd_number_data_2_subtractor_1));

 //This is the instance of the clock divider module
 clock_divider display_clock_inst(.clk_in(clock), .clk_out(display_clock));
 
 //This is an instance of the LCD module
 write_to_display write_to_display_inst(.clock(display_clock), .select_entry(select_entry), 
 .enable_entry(enable_entry), .data_1_adder_1(bcd_number_data_1_adder_1), 
 .data_2_adder_1(bcd_number_data_2_adder_1), 
 .data_1_subtractor_1(bcd_number_data_1_subtractor_1), 
 .data_2_subtractor_1(bcd_number_data_2_subtractor_1), .hex_7(hex_7), 
 .hex_6(hex_6), .hex_5(hex_5), .hex_4(hex_4), .hex_3(hex_3), .hex_2(hex_2), 
 .hex_1(hex_1), .hex_0(hex_0));
 
endmodule