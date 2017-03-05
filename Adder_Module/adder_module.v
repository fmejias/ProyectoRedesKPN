module adder_module (
entry_1,
entry_2,
add,
result,
show_result
);

/*
 * We define the type of entries and outputs
 */

input [15:0] entry_1;
input [15:0] entry_2; 
input add;
output [15:0] result;
output show_result;


/*
 * We make the add operation.
 * Also, we enable the show_result signal
 */

 
 assign result = (add == 1'b0) ? (entry_1 + entry_2) : 16'h0000;
 assign show_result = (add == 1'b0) ? 1'b1 : 1'b0;


endmodule // end adder_module