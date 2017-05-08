// FIFO_Module
module lcd_fifo
   #(
    parameter B=16, // number of bits in a word
              W=5  // number of address bits
   )
   (
    input wire clk,
    input wire rd, wr,
    input wire [B-1:0] entry_1,
    output reg [B-1:0] output_1
   );

   //signal declaration
   reg [B-1:0] array_reg [2**W-1:0];  // register array
   reg [W-1:0] w_ptr_next, w_ptr_succ;
   reg [W-1:0] r_ptr_next, r_ptr_succ;
   reg full_next, empty_next;
	reg [W-1:0] w_ptr_reg = 5'h00;
	reg [W-1:0] r_ptr_reg = 5'h00;
	reg empty_reg = 1'b1;
	reg full_reg = 1'b0;
	reg [15:0] buffer = 16'h0000;
   wire wr_en;
	wire empty;
	wire full;
	integer i;
	reg count = 1'b0;
	
	/*
    * Initialize the file with precharge data
    */
 
    initial
	 begin
		output_1 = 16'h0000;
    end

	
	always @(posedge clk)
	begin
      if (rd == 1'b1)begin
         output_1 = array_reg[r_ptr_reg];
		end
	end 
   
	// write enabled only when FIFO is not full
   assign wr_en = wr & ~full_reg;

   // fifo control logic
   // register for read and write pointers
   always @(posedge clk)
	begin
		w_ptr_reg = w_ptr_next;
		r_ptr_reg = r_ptr_next;
		full_reg = full_next;
		empty_reg = empty_next;
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
            if (~full_reg && entry_1 > 16'h0000) // not full
               begin
                  w_ptr_next = w_ptr_succ;
                  empty_next = 1'b0;
						
						/*This is need it  to write correctly*/
						if(entry_1 != buffer && count == 1'b1) 
						begin
							array_reg[w_ptr_reg] = buffer;
							count = 1'b0;
						end
						if(entry_1 != buffer)
							count = 1'b1;
						
						/* Add the buffer */
						buffer = entry_1;

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

   // output
   assign full = full_reg;
   assign empty = empty_reg;

endmodule