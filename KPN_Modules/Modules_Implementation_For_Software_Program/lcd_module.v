//It has a 16 bit input and a 32-bit output port
module lcd_module (
clock,
rd,
entry_1,
enable,
lcd_data,
rs,
rw,
on
);

/*
 * We define the type of entries and outputs
 */

input clock; 
input [15:0] entry_1;
output rd;
output enable;
output [7:0] lcd_data;
output rs;
output rw;
output on;


/*
 * We define the registers need it to show the entire entry in the LCD
 * The register entry_letter_counter is updating in order to go over all the letters
 * Is of 5 bits because the entry is compose by 16 digits.
 * lcd_data: Contains the address or the letter code
 * write_address: Indicates if it has to write a letter or the address. 
 * 		(1 indicates to write the address and 0 indicates to write the letter)
 * start_writing: Indicates to go over the number and write it in the DDRAM
 * cursor_address: Contains the cursor address
 */
reg [7:0] lcd_data = 8'b00000001;
reg [4:0] entry_letter_counter = 5'b01111;
reg write_address = 1'b0;
reg enable = 1'b1; 
reg rs = 1'b0;
reg rw = 1'b0;
reg activateRd = 1'b0;
reg command_delay = 1'b1;
reg entry_1_finished = 1'b0;
reg result_title_finished = 1'b0;
reg on = 1'b1;
reg already_read = 1'b0;
reg need_to_read = 1'b0;
reg start_writing_entry_1 = 1'b0;
reg start_writing_result = 1'b0;
reg [6:0] cursor_address = 7'b0000000; //The bit 7 is for write address
reg [15:0] entry_from_fifo = 16'h0000;
reg [4:0] prueba = 5'd0;

always @(posedge clock)
begin
activateRd = ~activateRd;
end

//In this part we activate the rd output
 /*always @(posedge clock)
 begin
	if(prueba == 4'd11)
	begin
		activateRd = 1'b1;
		prueba = prueba + 1;
		rd = 1'b1;
	end
	else if(prueba == 4'd14)
	begin
		rd = 1'b0;
		activateRd = 1'b0;
		prueba = 4'd0;
	end
	else
		prueba = prueba + 1;
		
 end*/


always @ (posedge clock) // on positive clock edge
begin

	if(command_delay)
   begin
	  enable = 1'b0;
	  command_delay = 1'b0;
	end 
	
 else if(start_writing_result == 1'b0 && result_title_finished == 1'b0 && start_writing_entry_1 == 1'b0) //Indicates to start writing to the LCD
   begin
	 already_read = 1'b0;
    start_writing_result = 1'b1;
	 entry_1_finished = 1'b0;
	 start_writing_entry_1 = 1'b0;
    write_address = 1'b1;
	 cursor_address = 7'h00;
	 
	/*
	 * We send this command from the beginning to clear the display data.
	 */
	rs = 1'b0;
	rw = 1'b0;
	lcd_data = 8'b00000001;
	command_delay = 1'b1;
   end
	
 else if(start_writing_entry_1 == 1'b0 && entry_1_finished == 1'b0 && start_writing_result == 1'b0) //Indicates to start writing to the LCD
   begin
    start_writing_entry_1 = 1'b1;
    write_address = 1'b1;
	 cursor_address = 7'h40;
	 result_title_finished = 1'b0;
	 start_writing_result = 1'b0;
	 entry_from_fifo = entry_1;
	 need_to_read = 1'b1;
	 $display("La entrada recibida es:", entry_1);
   end

 else
   begin
		if(start_writing_entry_1 == 1'b1)
		  begin
			if(write_address == 1'b1)
	        begin
				 need_to_read = 1'b0;
			    already_read = 1'b1;
				 rs = 1'b0;
				 rw = 1'b0;
				 enable = 1'b1; 
				 entry_1_finished = (cursor_address == 7'h50 && entry_1_finished == 1'b0) ? 1'b1 : entry_1_finished;
				 start_writing_entry_1 =  (entry_1_finished == 1'b1) ? 1'b0 : 1'b1;
			    cursor_address = (cursor_address == 7'h50) ? 7'h00 : cursor_address;
				 lcd_data = {1'b1, cursor_address};		 
				 write_address = 1'b0;
				 command_delay = 1'b1;
				 
			  end
			else
			  begin
				 need_to_read = 1'b0;
			    already_read = 1'b1;
			    rs = 1'b1;
				 rw = 1'b0;
				 $display("Estoy escribiendo:", entry_1[entry_letter_counter]);
			    lcd_data = (entry_1[entry_letter_counter] == 1'b1) ? 8'b00110001: 8'b00110000;
				 entry_letter_counter = (entry_letter_counter == 5'b00000) ? 5'b01111 : entry_letter_counter - 1;
				 write_address = 1'b1;
				 cursor_address = cursor_address + 1;
				 enable = 1'b1;
				 command_delay = 1'b1;
			  end
		  end
		  
		else if(start_writing_result)
		  begin
			if(write_address == 1'b1)
	        begin
				 rs = 1'b0;
				 rw = 1'b0;
				 enable = 1'b1; 
				 result_title_finished = (cursor_address == 7'h0B && result_title_finished == 1'b0) ? 1'b1 : result_title_finished;
				 start_writing_result =  (result_title_finished == 1'b1) ? 1'b0 : 1'b1;
				 cursor_address = (cursor_address == 7'h0B) ? 7'h40 : cursor_address;
				 lcd_data = {1'b1, cursor_address};
				 write_address = 1'b0;
				 command_delay = 1'b1;
			  end
			else
			  begin
			    rs = 1'b1;
				 rw = 1'b0;
			    lcd_data = (cursor_address == 7'h00) ? 8'b01001011: 8'b10110000; //K
				 lcd_data = (cursor_address == 7'h01) ? 8'b01010000: lcd_data; //P
				 lcd_data = (cursor_address == 7'h02) ? 8'b01001110: lcd_data; //N
				 lcd_data = (cursor_address == 7'h03) ? 8'b00100000: lcd_data; //Space
				 lcd_data = (cursor_address == 7'h04) ? 8'b01001111: lcd_data; //O
				 lcd_data = (cursor_address == 7'h05) ? 8'b01110101: lcd_data; //u
				 lcd_data = (cursor_address == 7'h06) ? 8'b01110100: lcd_data; //t
				 lcd_data = (cursor_address == 7'h07) ? 8'b01110000: lcd_data; //p
				 lcd_data = (cursor_address == 7'h08) ? 8'b01110101: lcd_data; //u
				 lcd_data = (cursor_address == 7'h09) ? 8'b01110100: lcd_data; //t
				 lcd_data = (cursor_address == 7'h0A) ? 8'b00111010: lcd_data; //:
				 write_address = 1'b1;
				 cursor_address = cursor_address + 1;
				 enable = 1'b1;
				 command_delay = 1'b1;
			  end
		  end  
		else
		  begin
		   enable = 1'b1;    
				
		  end
   end

end

//Assign the read signal 
assign rd = ((activateRd == 1'b1 && start_writing_entry_1 == 1'b1 && already_read == 1'b0) 
				|| (activateRd == 1'b0 && start_writing_entry_1 == 1'b1 && already_read == 1'b0)) ? 1'b1 : 1'b0;

//assign rd = ((activateRd == 1'b1) ||(activateRd == 1'b0) ) ? 1'b1 : 1'b0;
//assign rd = (prueba == 4'd11) ? 1'b1 : 1'b0;			
				
endmodule // end of module lcd