module queue_module(
clk,
wr,
output_1
);

/*
 * We define the parameters
 */

parameter BITS_NUMBER = 16;
parameter FIFO_ELEMENTS = 5; //==> 2**5 elements
parameter NUMBER_OF_PRECHARGE_DATA = 4;

/*
 * We define the type of entries and outputs
 */
input clk;
output wr;
output [BITS_NUMBER-1:0] output_1;

//signal declaration
reg [BITS_NUMBER-1:0] array_reg [2**FIFO_ELEMENTS-1:0];  // register array
reg [FIFO_ELEMENTS-1:0] w_ptr_reg = 0;
reg [FIFO_ELEMENTS-1:0] w_ptr_next, w_ptr_succ;
reg [FIFO_ELEMENTS-1:0] r_ptr_reg = 0;
reg [FIFO_ELEMENTS-1:0] r_ptr_next, r_ptr_succ;
reg full_reg = 1'b0;
reg empty_reg = 1'b0;
reg full_next, empty_next;
wire wr_en;
wire empty;
reg [BITS_NUMBER-1:0] output_1 = 16'h0000;


/*
 * Initialize the file with precharge data
 */
 
initial
begin
	$readmemh("C:/Users/Felipe/Desktop/Tec/ProyectoDiseno/ProyectoGithub/ProyectoRedesKPN/KPN_Modules/Modules_Implementation_For_Software_Program/Test_Modules/queue_precharge_data.txt", array_reg);
	w_ptr_reg = 5'h04;
	r_ptr_reg = 5'h00;
	empty_reg = 1'b0;
	
	output_1 = 16'h0000;

end

// Read operation
always @(posedge clk)
	begin
		r_ptr_succ = r_ptr_reg + 1;
		if(~empty_reg)
		begin
		output_1 = array_reg[r_ptr_reg];
		r_ptr_reg = r_ptr_succ;
		full_reg = 1'b0;
		if (r_ptr_succ==w_ptr_reg)
			empty_reg = 1'b1;

		end
		else
		output_1 = 16'h0000;
	end

assign wr = (clk == 1'b0) ? 1'b1 : 1'b0;


endmodule // end queue_module