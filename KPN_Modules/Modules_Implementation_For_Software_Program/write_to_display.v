module write_to_display (
clk,
entry_1,
hex_4,
hex_3,
hex_2,
hex_1,
hex_0
);


/*
 * We define the type of entries and outputs
 */

input clk; 
input [15:0] entry_1;
output [6:0] hex_4;
output [6:0] hex_3;
output [6:0] hex_2;
output [6:0] hex_1;
output [6:0] hex_0;



/*
 * Here, we declare some signals need it in this module
 *
 *
 */
 
 reg [6:0] hex_4;
 reg [6:0] hex_3;
 reg [6:0] hex_2;
 reg [6:0] hex_1;
 reg [6:0] hex_0;
 
 reg [3:0] thousands;
 reg [3:0] hundreds;
 reg [3:0] tens;
 reg [3:0] ones;

  
/*
 * Here, we draw in the HEX4 display
 *
 *
 */
 
 always @(posedge clk)
 begin
 hex_4 = 7'b0010010; //This instruction draws a S in the HEX4
 end
 
 
 
 /*
 * Here, we draw in the HEX3, HEX2, HEX1 and HEX0 displays
 *
 *
 */
 
/* always @(posedge clk)
 begin
	thousands = entry_1[15:12];
	hundreds = entry_1[11:8];
	tens = entry_1[7:4];
	ones = entry_1[3:0];
	$display("Los miles son:", thousands);
	$display("Las centenas son:", hundreds);
	$display("Las decenas son:", tens);
	$display("Las unidades son:", ones);
 end */
 
 always @(entry_1)
 begin
	thousands = entry_1[15:12];
	hundreds = entry_1[11:8];
	tens = entry_1[7:4];
	ones = entry_1[3:0];
 end
 
 
 /*
 * Here, we draw in the HEX3 display
 *
 *
 */
 
 always @(entry_1)
 begin
 
 if(thousands == 4'b0000) 
 begin
 hex_3 = 7'b1000000; //This instruction draws a 0 in the HEX3
 end
 else if(thousands == 4'b0001) 
 begin
 hex_3 = 7'b1111001; //This instruction draws a 1 in the HEX3
 end
 else if(thousands == 4'b0010) 
 begin
 hex_3 = 7'b0100100; //This instruction draws a 2 in the HEX3
 end
 else if(thousands == 4'b0011) 
 begin
 hex_3 = 7'b0110000; //This instruction draws a 3 in the HEX3
 end
 else if(thousands == 4'b0100) 
 begin
 hex_3 = 7'b0011001; //This instruction draws a 4 in the HEX3
 end
 else if(thousands == 4'b0101) 
 begin
 hex_3 = 7'b0010010; //This instruction draws a 5 in the HEX3
 end
 else if(thousands == 4'b0110) 
 begin
 hex_3 = 7'b0000010; //This instruction draws a 6 in the HEX3
 end
 else if(thousands == 4'b0111) 
 begin
 hex_3 = 7'b1011000; //This instruction draws a 7 in the HEX3
 end
 else if(thousands == 4'b1000) 
 begin
 hex_3 = 7'b0000000; //This instruction draws a 8 in the HEX3
 end
 else if(thousands == 4'b1001) 
 begin
 hex_3 = 7'b0011000; //This instruction draws a 9 in the HEX3
 end
 else
 begin
 hex_3 = 7'b1000000; //This instruction draws a 0 in the HEX3
 end
 
 
 end
 
 
 always @(entry_1)
 begin
 
 if(hundreds == 4'b0000) 
 begin
 hex_2 = 7'b1000000; //This instruction draws a 0 in the HEX3
 end
 else if(hundreds == 4'b0001) 
 begin
 hex_2 = 7'b1111001; //This instruction draws a 1 in the HEX3
 end
 else if(hundreds == 4'b0010) 
 begin
 hex_2 = 7'b0100100; //This instruction draws a 2 in the HEX3
 end
 else if(hundreds == 4'b0011) 
 begin
 hex_2 = 7'b0110000; //This instruction draws a 3 in the HEX3
 end
 else if(hundreds == 4'b0100) 
 begin
 hex_2 = 7'b0011001; //This instruction draws a 4 in the HEX3
 end
 else if(hundreds == 4'b0101) 
 begin
 hex_2 = 7'b0010010; //This instruction draws a 5 in the HEX3
 end
 else if(hundreds == 4'b0110) 
 begin
 hex_2 = 7'b0000010; //This instruction draws a 6 in the HEX3
 end
 else if(hundreds == 4'b0111) 
 begin
 hex_2 = 7'b1011000; //This instruction draws a 7 in the HEX3
 end
 else if(hundreds == 4'b1000) 
 begin
 hex_2 = 7'b0000000; //This instruction draws a 8 in the HEX3
 end
 else if(hundreds == 4'b1001) 
 begin
 hex_2 = 7'b0011000; //This instruction draws a 9 in the HEX3
 end
 else
 begin
 hex_2 = 7'b1000000; //This instruction draws a 0 in the HEX3
 end
 
 
 end
 
 /*
 * Here, we draw in the HEX2 display
 *
 *
 */
 
 /*always @(posedge clk)
 begin
 
 case(hundreds)
	4'b0000: 
		begin
			hex_2 = 7'b1000000; //This instruction draws a 0 in the HEX2
		end
		
	4'b0001: 
		begin
			hex_2 = 7'b1111001; //This instruction draws a 1 in the HEX2
		end
		
	4'b0010: 
		begin
			hex_2 = 7'b0100100; //This instruction draws a 2 in the HEX2
		end
		
	4'b0011: 
		begin
			hex_2 = 7'b0110000; //This instruction draws a 3 in the HEX2
		end
		
	4'b0100: 
		begin
			hex_2 = 7'b0011001; //This instruction draws a 4 in the HEX2
		end
		
	4'b0101: 
		begin
			hex_2 = 7'b0010010; //This instruction draws a 5 in the HEX2
		end
		
	4'b0110: 
		begin
			hex_2 = 7'b0000010; //This instruction draws a 6 in the HEX2
		end
		
	4'b0111: 
		begin
			hex_2 = 7'b1011000; //This instruction draws a 7 in the HEX2
		end
		
	4'b1000: 
		begin
			hex_2 = 7'b0000000; //This instruction draws a 8 in the HEX2
		end
		
	4'b1001: 
		begin
			hex_2 = 7'b0011000; //This instruction draws a 9 in the HEX2
		end
		
	default:
		begin
			hex_2 = 7'b1000000; //This instruction draws a 0 in the HEX2; 
		end
		
 endcase
 end
 */
 
 
 /*
 * Here, we draw in the HEX1 display
 *
 *
 */
 
 always @(entry_1)
 begin
 
 if(tens == 4'b0000) 
 begin
 hex_1 = 7'b1000000; //This instruction draws a 0 in the HEX3
 end
 else if(tens == 4'b0001) 
 begin
 hex_1 = 7'b1111001; //This instruction draws a 1 in the HEX3
 end
 else if(tens == 4'b0010) 
 begin
 hex_1 = 7'b0100100; //This instruction draws a 2 in the HEX3
 end
 else if(tens == 4'b0011) 
 begin
 hex_1 = 7'b0110000; //This instruction draws a 3 in the HEX3
 end
 else if(tens == 4'b0100) 
 begin
 hex_1 = 7'b0011001; //This instruction draws a 4 in the HEX3
 end
 else if(tens == 4'b0101) 
 begin
 hex_1 = 7'b0010010; //This instruction draws a 5 in the HEX3
 end
 else if(tens == 4'b0110) 
 begin
 hex_1 = 7'b0000010; //This instruction draws a 6 in the HEX3
 end
 else if(tens == 4'b0111) 
 begin
 hex_1 = 7'b1011000; //This instruction draws a 7 in the HEX3
 end
 else if(tens == 4'b1000) 
 begin
 hex_1 = 7'b0000000; //This instruction draws a 8 in the HEX3
 end
 else if(tens == 4'b1001) 
 begin
 hex_1 = 7'b0011000; //This instruction draws a 9 in the HEX3
 end
 else
 begin
 hex_1 = 7'b1000000; //This instruction draws a 0 in the HEX3
 end
 
 
 end
 
 /*
 * Here, we draw in the HEX1 display
 *
 *
 */
 
 /*always @(posedge clk)
 begin
 
 case(tens)
	4'b0000: 
		begin
			hex_1 = 7'b1000000; //This instruction draws a 0 in the HEX1
		end
		
	4'b0001: 
		begin
			hex_1 = 7'b1111001; //This instruction draws a 1 in the HEX1
		end
		
	4'b0010: 
		begin
			hex_1 = 7'b0100100; //This instruction draws a 2 in the HEX1
		end
		
	4'b0011: 
		begin
			hex_1 = 7'b0110000; //This instruction draws a 3 in the HEX1
		end
		
	4'b0100: 
		begin
			hex_1 = 7'b0011001; //This instruction draws a 4 in the HEX1
		end
		
	4'b0101: 
		begin
			hex_1 = 7'b0010010; //This instruction draws a 5 in the HEX1
		end
		
	4'b0110: 
		begin
			hex_1 = 7'b0000010; //This instruction draws a 6 in the HEX1
		end
		
	4'b0111: 
		begin
			hex_1 = 7'b1011000; //This instruction draws a 7 in the HEX1
		end
		
	4'b1000: 
		begin
			hex_1 = 7'b0000000; //This instruction draws a 8 in the HEX1
		end
		
	4'b1001: 
		begin
			hex_1 = 7'b0011000; //This instruction draws a 9 in the HEX1
		end
		
	default:
		begin
			hex_1 = 7'b1000000; //This instruction draws a 0 in the HEX1
		end
		
 endcase
 end */
 
 
 /*
 * Here, we draw in the HEX1 display
 *
 *
 */
 
 always @(entry_1)
 begin
 
 if(ones == 4'b0000) 
 begin
 hex_0 = 7'b1000000; //This instruction draws a 0 in the HEX3
 end
 else if(ones == 4'b0001) 
 begin
 hex_0 = 7'b1111001; //This instruction draws a 1 in the HEX3
 end
 else if(ones == 4'b0010) 
 begin
 hex_0 = 7'b0100100; //This instruction draws a 2 in the HEX3
 end
 else if(ones == 4'b0011) 
 begin
 hex_0 = 7'b0110000; //This instruction draws a 3 in the HEX3
 end
 else if(ones == 4'b0100) 
 begin
 hex_0 = 7'b0011001; //This instruction draws a 4 in the HEX3
 end
 else if(ones == 4'b0101) 
 begin
 hex_0 = 7'b0010010; //This instruction draws a 5 in the HEX3
 end
 else if(ones == 4'b0110) 
 begin
 hex_0 = 7'b0000010; //This instruction draws a 6 in the HEX3
 end
 else if(ones == 4'b0111) 
 begin
 hex_0 = 7'b1011000; //This instruction draws a 7 in the HEX3
 end
 else if(ones == 4'b1000) 
 begin
 hex_0 = 7'b0000000; //This instruction draws a 8 in the HEX3
 end
 else if(ones == 4'b1001) 
 begin
 hex_0 = 7'b0011000; //This instruction draws a 9 in the HEX3
 end
 else
 begin
 hex_0 = 7'b1000000; //This instruction draws a 0 in the HEX3
 end
 
 
 end
 
 
 /*
 * Here, we draw in the HEX0 display
 *
 *
 */
 
 /*always @(posedge clk)
 begin
 
 case(ones)
	4'b0000: 
		begin
			hex_0 = 7'b1000000; //This instruction draws a 0 in the HEX0
		end
		
	4'b0001: 
		begin
			hex_0 = 7'b1111001; //This instruction draws a 1 in the HEX0
		end
		
	4'b0010: 
		begin
			hex_0 = 7'b0100100; //This instruction draws a 2 in the HEX0
		end
		
	4'b0011: 
		begin
			hex_0 = 7'b0110000; //This instruction draws a 3 in the HEX0
		end
		
	4'b0100: 
		begin
			hex_0 = 7'b0011001; //This instruction draws a 4 in the HEX0
		end
		
	4'b0101: 
		begin
			hex_0 = 7'b0010010; //This instruction draws a 5 in the HEX0
		end
		
	4'b0110: 
		begin
			hex_0 = 7'b0000010; //This instruction draws a 6 in the HEX0
		end
		
	4'b0111: 
		begin
			hex_0 = 7'b1011000; //This instruction draws a 7 in the HEX0
		end
		
	4'b1000: 
		begin
			hex_0 = 7'b0000000; //This instruction draws a 8 in the HEX0
		end
		
	4'b1001: 
		begin
			hex_0 = 7'b0011000; //This instruction draws a 9 in the HEX0
		end
		
	default:
		begin
			hex_0 = 7'b1000000; //This instruction draws a 0 in the HEX0
		end
		
 endcase
 end */
 
endmodule