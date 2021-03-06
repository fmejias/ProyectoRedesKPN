module top_module (
entry_1,
show_entries,
clock,
reset,
add_button,
rs,
rw,
on,
en,
lcd_data
);

/*
 * We define the type of entries and outputs
 */

input [15:0] entry_1; 
input show_entries;
input clock;
input reset;
input add_button;
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

 wire lcd_clock;
 wire show_result;
 wire [15:0] result;
 wire entry_2_finished; //This is use to show the result of the adder

/*
 * Here, we instantiate the modules
 *
 *
 */
 

 //This is the instance of the clock divider module
 clock_divider lcd_clock_inst(.clk_in(clock), .clk_out(lcd_clock));
 
 //This is the instance of the adder module
 adder_module adder_inst(.entry_1(entry_1), .entry_2(entry_1), .reset(reset),  .add(show_entries), .show_add(entry_2_finished), .result(result), .show_result(show_result));

 //This is an instance of the LCD module
 write_to_lcd write_to_lcd_inst(.entry_1(entry_1), .entry_2(entry_1), .show_entry_1(show_entries), .show_entry_2(show_entries), .reset(reset), .show_result(show_result), .clock(lcd_clock), .result(result), .rs(rs), .rw(rw), .on(on), .enable(en), .lcd_data(lcd_data), .entry_2_finished(entry_2_finished));
 
endmodule