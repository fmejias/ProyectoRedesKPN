module clock_divider(
clk_in, 
clk_out
);

/*
 * We define the entries and outputs
 */
 
input clk_in;
output clk_out;

//The value of the M parameter is use to divide it with the 50 MHz frequency of the CLK
parameter M = 100_000_000;

/*
 * We make the clock divider operation.
 * 
 */
 
localparam N = $clog2(M);
reg [N-1:0] divcounter = 0;

always @(posedge clk_in)
  if (divcounter == M - 1) 
    divcounter <= 0;
  else 
    divcounter <= divcounter + 1;

//Assign the new clock to the output
assign clk_out = divcounter[N-1];

endmodule