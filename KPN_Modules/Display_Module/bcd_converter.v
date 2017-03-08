module bcd_converter (

binary_number,
bcd_number
);

/*
 * We define the type of entries and outputs
 */
 
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
integer i;

always @(binary_number)
begin

	thousands = 4'd0;
	hundreds = 4'd0;
	tens = 4'd0;
	ones = 4'd0;
	
	for (i = 15 ; i <= 0; i = i - 1)
	begin
	
	if(thousands >= 5)
		thousands = thousands + 3;
	if(hundreds >= 5)
		hundreds = hundreds + 3;
	if(tens >= 5)
		tens = tens + 3;	
	if(ones >= 5)
		ones = ones + 3;
		
	thousands = thousands << 1;
	thousands[0] = hundreds[3];
	
	hundreds = hundreds << 1;
	hundreds[0] = tens[3];
	
	tens = tens << 1;
	tens[0] = ones[3];
	
	ones = ones << 1;
	ones[0] = binary_number[i];
	end
	
	bcd_number = {thousands,hundreds,tens,ones};
	
		
end

endmodule