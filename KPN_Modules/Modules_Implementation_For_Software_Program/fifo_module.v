module fifo_module(
clk,
rd,
wr,
entry_1,
output_1
);

/*
 * We define the parameters
 */

parameter BITS_NUMBER = 16;
parameter FIFO_ELEMENTS = 5; //==> 2**5 elements

/*
 * We define the type of entries and outputs
 */
 
input clk;
input rd;
input wr;
input [BITS_NUMBER-1:0] entry_1; 
output [BITS_NUMBER-1:0] output_1;


//signal declaration
reg [BITS_NUMBER-1:0] array_reg [2**FIFO_ELEMENTS-1:0];  // register array
reg [FIFO_ELEMENTS-1:0] w_ptr_reg = 0;
reg [FIFO_ELEMENTS-1:0] w_ptr_next, w_ptr_succ;
reg [FIFO_ELEMENTS-1:0] r_ptr_reg = 0;
reg [FIFO_ELEMENTS-1:0] r_ptr_next, r_ptr_succ;
reg full_reg = 1'b0;
reg empty_reg = 1'b1;
reg full_next, empty_next;
reg [BITS_NUMBER-1:0] output_1 = 16'h0000;
wire wr_en;
wire empty;


// next-state logic for read and write pointers
always @(rd,wr)
begin
	
	// successive pointer values
	if(wr)
	begin
		if (~full_reg) //not full
		begin
		empty_reg = 1'b0;
		array_reg[w_ptr_reg] = entry_1;
		w_ptr_succ = w_ptr_reg + 1;
		w_ptr_reg = w_ptr_succ;
		if (w_ptr_succ==r_ptr_reg)
			full_reg = 1'b1;
		end
	end
	else if(rd)
	begin
		if(~empty_reg)
		begin
		output_1 = array_reg[r_ptr_reg];
		r_ptr_succ = r_ptr_reg + 1;
		r_ptr_reg = r_ptr_succ;
		full_reg = 1'b0;
		if (r_ptr_succ==w_ptr_reg)
		begin
			empty_reg = 1'b1;
		end
		end
			
		else
		begin
			
		end
	end

end

assign empty = empty_reg;

endmodule // end fifo_module