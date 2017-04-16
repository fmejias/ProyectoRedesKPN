module top_module (
entry_1,
show_entries,
clock,
reset,
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
 wire show_outputs;
 wire entry_1_finished;
 wire [15:0] output_1;
 wire [15:0] output_2;

/*
 * Here, we instantiate the modules
 *
 *
 */
 

 //This is the instance of the clock divider module
 clock_divider lcd_clock_inst(.clk_in(clock), .clk_out(lcd_clock));
 
 //This is the instance of the split module
 split_module split_inst(.entry_1(entry_1), .reset(reset), .entry_1_finished(entry_1_finished),  .output_1(output_1),
 .output_2(output_2), .show_outputs(show_outputs));

 //This is an instance of the LCD module
 write_to_lcd write_to_lcd_inst(.entry_1(entry_1),
 .show_entry_1(show_entries), .show_output_1(show_outputs), .entry_1_finished(entry_1_finished), 
 .reset(reset), .show_output_2(show_outputs), .clock(lcd_clock), 
 .output_1(output_1), .output_2(output_2), .rs(rs), .rw(rw), .on(on), .enable(en), 
 .lcd_data(lcd_data));
 
endmodule