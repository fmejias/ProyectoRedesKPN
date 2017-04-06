module top_module (
clk,
entry_1,
entry_2,
output_1
);

/*
 * We define the type of entries and outputs
 */

input clk;
input [15:0] entry_1;
input [15:0] entry_2; 
output [15:0] output_1;


/*
 * Here, we declare some signals need it to pass information between modules
 *
 *
 */

 wire divide_clock;


/*
 * Here, we instantiate the modules
 *
 *
 */
 

 
endmodule