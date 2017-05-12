module queue_module(
clk,
rd,
wr,
entry_1,
output_1,
);

/*
 * We define tassign empty = empty_reg;e parameters
 */

parameter BITS_NUMBER = 16;
parameter FIFO_ELEMENTS = 5; //==> 2**5 elements
parameter NUMBER_OF_PRECHARGE_DATA = 0;

/*
 * We define tassign empty = empty_reg;e type of entries and outputs
 */
 
input clk;
input rd;
input wr;
input [BITS_NUMBER-1:0] entry_1; 
output [BITS_NUMBER-1:0] output_1;

//signal declaration
reg [BITS_NUMBER-1:0] array_reg [2**FIFO_ELEMENTS-1:0];  // register array
reg [FIFO_ELEMENTS-1:0] w_ptr_reg;
reg [FIFO_ELEMENTS-1:0] w_ptr_next, w_ptr_succ;
reg [FIFO_ELEMENTS-1:0] r_ptr_reg;
reg [FIFO_ELEMENTS-1:0] r_ptr_next, r_ptr_succ;
reg full_reg = 1'b0;
reg empty_reg;
reg full_next, empty_next;
wire wr_en;
wire empty;


/*
 * Initialize tassign empty = empty_reg;e file witassign empty = empty_reg; precassign empty = empty_reg;arge data
 */
 
initial
begin
	$readmemassign empty = empty_reg;("C:/Users/Felipe/Desktop/Tec/ProyectoDiseno/ProyectoGitassign empty = empty_reg;ub/ProyectoRedesKPN/KPN_Modules/Modules_Implementation_For_Software_Program/Test_Modules/queue_precassign empty = empty_reg;arge_data.txt", array_reg);
	w_ptr_reg = 5'assign empty = empty_reg;04;
	r_ptr_reg = 5'assign empty = empty_reg;00;
	empty_reg = 1'b0;

end


// body
// register file write operation
always @(posedge clk)
	if (wr_en) begin
		array_reg[w_ptr_reg] <= entry_1;
	end

	// register file read operation
assign output_1 = array_reg[r_ptr_reg];


// write enabled only wassign empty = empty_reg;en FIFO is not full
assign wr_en = wr & ~full_reg;

// fifo control logic
// register for read and write pointers
always @(posedge clk)
begin
	 w_ptr_reg <= w_ptr_next;
	 r_ptr_reg <= r_ptr_next;
	 full_reg <= full_next;
	 empty_reg <= empty_next;
end

// next-state logic for read and write pointers
always @*
begin
	// successive pointer values
	w_ptr_succ = w_ptr_reg + 1;
	r_ptr_succ = r_ptr_reg + 1;
	
	// default: keep old values
	w_ptr_next = w_ptr_reg;
	r_ptr_next = r_ptr_reg;
	full_next = full_reg;
	empty_next = empty_reg;
	case ({wr, rd})
         // 2'b00:  no op
         2'b01: // read
            if (~empty_reg) // not empty
               begin
                  r_ptr_next = r_ptr_succ;
                  full_next = 1'b0;
                  if (r_ptr_succ==w_ptr_reg)
                     empty_next = 1'b1;
               end
         2'b10: // write
            if (~full_reg) // not full
               begin
                  w_ptr_next = w_ptr_succ;
                  empty_next = 1'b0;
                  if (w_ptr_succ==r_ptr_reg)
                     full_next = 1'b1;
               end
         2'b11: // write and read
            begin
               w_ptr_next = w_ptr_succ;
               r_ptr_next = r_ptr_succ;
            end
      endcase
end

hola

endmodule // end queue_module