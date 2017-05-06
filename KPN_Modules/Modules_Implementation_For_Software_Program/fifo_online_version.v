module fifo_online_version
  (input wire clk,
   input wire [15:0] entry_1,
   input wire wr,
   input wire rd,
   output reg [15:0] output_1); // N
 
  reg [7:0] wr_ptr= 8'b0; // N-1
  reg [7:0] rd_ptr= 8'b0; // N-1
  reg [8:0] full_indicator = 9'b0;
 
  reg[15:0] fifo_mem[2**8-1:0];
  
  wire full;
  wire empty;
 
  assign full = (full_indicator == 2**8);
  assign empty = (full_indicator == 8'b0);
 
  always @(posedge clk)
      begin
        case ({rd, wr})
          2'b00: // nothing
            begin
              full_indicator = full_indicator;
            end
          2'b01: // write
            begin
              if  (full_indicator < 2**8)
                begin
                  full_indicator = full_indicator + 1;
                  fifo_mem[wr_ptr] = entry_1;
                  wr_ptr = wr_ptr + 1;
                end
            end
          2'b10: // read
            begin
              if (full_indicator > 0)
                begin
                  output_1 = fifo_mem[rd_ptr];
                  full_indicator = full_indicator - 1;
                  rd_ptr = rd_ptr + 1;
                end
            end
          2'b11: // read+write
            begin
              wr_ptr = wr_ptr + 1;
              rd_ptr = rd_ptr + 1;
              output_1 = fifo_mem[rd_ptr];
              fifo_mem[wr_ptr] = entry_1;
              full_indicator = full_indicator;
            end
        endcase
      end
endmodule