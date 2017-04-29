module bcd_converter (
clk,
binary_number,
bcd_number
);

/*
 * We define the type of entries and outputs
 */
input clk;
input [15:0] binary_number;
output [15:0] bcd_number;


/*
 * Here, we declare some signals need it in this module
 *
 *
 */

reg [15:0] bcd_number; 
reg [3:0] thousands;
reg [3:0] hundreds;
reg [3:0] tens;
reg [3:0] ones;

// Internal variable for storing bits
reg [31:0] shift;
integer i;
   
always @(negedge clk)
begin
	 // $display("La entrada recibida es:", binary_number);
    // Clear previous number and store new number in shift register
    shift[31:15] = 0;
    shift[15:0] = binary_number;
	// prueba = prueba + 16'd10;
      
    // Loop eight times
    for (i=0; i<16; i=i+1) begin
		 if (shift[19:16] >= 5)
          shift[19:16] = shift[19:16] + 3;
			 
       if (shift[23:20] >= 5)
          shift[23:20] = shift[23:20] + 3;
            
       if (shift[27:24] >= 5)
          shift[27:24] = shift[27:24] + 3;
            
       if (shift[31:28] >= 5)
          shift[31:28] = shift[31:28] + 3;
         
        // Shift entire register left once
        shift = shift << 1;
     end
      
     // Push decimal numbers to output
	  thousands = shift[31:28];
     hundreds = shift[27:24];
     tens     = shift[23:20];
     ones     = shift[19:16];
	  bcd_number = {thousands, hundreds,tens,ones};
end

endmodule