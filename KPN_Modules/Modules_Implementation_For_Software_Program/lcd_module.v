module write_to_display (
clock,
select_entry,
select_module,
enable_entry,
data_1_adder_1,
data_2_adder_1,
data_1_subtractor_1,
data_2_subtractor_1,
hex_7,
hex_6,
hex_5,
hex_4,
hex_3,
hex_2,
hex_1,
hex_0
);


/*
 * We define the type of entries and outputs
 */

input clock; 
input select_entry;
input [4:0] select_module;
input enable_entry;
input [15:0] data_1_adder_1;
input [15:0] data_2_adder_1;
input [15:0] data_1_subtractor_1;
input [15:0] data_2_subtractor_1;
output [6:0] hex_7;
output [6:0] hex_6;
output [6:0] hex_5;
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
 
 reg [6:0] hex_7;
 reg [6:0] hex_6;
 reg [6:0] hex_5;
 reg [6:0] hex_4;
 reg [6:0] hex_3;
 reg [6:0] hex_2;
 reg [6:0] hex_1;
 reg [6:0] hex_0;
 
 reg [1:0] actual_entry;
 reg [5:0] actual_module;
 reg [17:0] actual_data; //This data has one more bit in case of an overflow
 reg [3:0] thousands;
 reg [3:0] hundreds;
 reg [3:0] tens;
 reg [3:0] ones;


/*
 * Here, we draw in the HEX7 and HEX6 displays
 *
 *
 */
 
 always @(posedge clock)
 begin
 
 if(select_entry)
 begin
	hex_7 = 7'b0000110; //This instruction draws an E in the HEX7
	hex_6 = 7'b0100100; //This instruction draws number 2 in the HEX6
	actual_entry = 2'b10; //This save the actual entry
 
 end
 
 else
 begin
	hex_7 = 7'b0000110; //This instruction draws an E in the HEX7
	hex_6 = 7'b1111001; //This instruction draws number 1 in the HEX6
	actual_entry = 2'b01; //This save the actual entry
 end
 
 end
 
 
 /*
 * Here, we draw in the HEX5 and HEX4 displays
 *
 *
 */
 
 always @(posedge clock)
 begin
 
 case(select_module)
	5'b00000: //Adder case
		begin
			hex_5 = 7'b0001000; //This instruction draws an A in the HEX5
			hex_4 = 7'b0100001; //This instruction draws a d in the HEX4
			actual_module = 5'b00000; //This save the actual module
		end
		
	5'b00001: //Subtractor case
		begin
			hex_5 = 7'b0010010; //This instruction draws a S in the HEX5
			hex_4 = 7'b1000001; //This instruction draws a U in the HEX4
			actual_module = 5'b00001; //This save the actual module
		end
		
	default:
		begin
			hex_5 = 7'b1111111; //This instruction turns off HEX5
			hex_4 = 7'b1111111; //This instruction turns off HEX4
		end
 endcase
 end
 
 
 
 /*
 * Here, we draw in the HEX3, HEX2, HEX1 and HEX0 displays
 *
 *
 */
 
 always @(posedge clock)
 begin
 
 if (select_entry)
 begin
	if(select_module == 5'b00000)
	begin
		actual_data = data_2_adder_1;
		thousands = data_2_adder_1[15:12];
		hundreds = data_2_adder_1[11:8];
		tens = data_2_adder_1[7:4];
		ones = data_2_adder_1[3:0];
	end
	else if(select_module == 5'b00001)
	begin
		actual_data = data_2_subtractor_1;
		thousands = data_2_subtractor_1[15:12];
		hundreds = data_2_subtractor_1[11:8];
		tens = data_2_subtractor_1[7:4];
		ones = data_2_subtractor_1[3:0];
	end
	else
	begin
		actual_data = 16'h0000;
	end
	
 end
 
 else
 begin
	if(select_module == 5'b00000)
	begin
		actual_data = data_1_adder_1;
		thousands = data_1_adder_1[15:12];
		hundreds = data_1_adder_1[11:8];
		tens = data_1_adder_1[7:4];
		ones = data_1_adder_1[3:0];
		
	end
	else if(select_module == 5'b00001)
	begin
		actual_data = data_1_subtractor_1;
		thousands = data_1_subtractor_1[15:12];
		hundreds = data_1_subtractor_1[11:8];
		tens = data_1_subtractor_1[7:4];
		ones = data_1_subtractor_1[3:0];
	end
	else
	begin
		actual_data = 16'h0000;
	end
 
 end
 
 end
 
 
 /*
 * Here, we draw in the HEX3 display
 *
 *
 */
 
 always @(posedge clock)
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
 
 
 end
 
 /*
 * Here, we draw in the HEX2 display
 *
 *
 */
 
 always @(posedge clock)
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
			hex_2 = 7'b1111111; //This instruction turns off HEX2
		end
		
 endcase
 end
 
 
 /*
 * Here, we draw in the HEX1 display
 *
 *
 */
 
 always @(posedge clock)
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
			hex_1 = 7'b1111111; //This instruction turns off HEX1
		end
		
 endcase
 end
 
 /*
 * Here, we draw in the HEX0 display
 *
 *
 */
 
 always @(posedge clock)
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
			hex_0 = 7'b1111111; //This instruction turns off HEX0
		end
		
 endcase
 end
 
endmodule