//It has a 16 bit input and a 32-bit output port
/* Input: entry_1[15:0]
 * Input: show_entry_1
 * Output: EN
 * Output: lcd_data[7:0]
 * Output: RS
 * Output: R/W
 */
module write_entry_to_lcd (
clock,
reset,
entry_1,
show_entry_1,
show_result,
enable,
lcd_data,
rs,
rw,
on,
ledPrueba
);

/*
 * We define the type of entries and outputs
 */

input clock; 
input reset;
input [15:0] entry_1;
input show_entry_1; //SW1
input show_result; //KEY[3]
output enable;
output [7:0] lcd_data;
output rs;
output rw;
output on;
output ledPrueba;


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
reg [7:0] lcd_data; 
reg [4:0] entry_letter_counter; 
reg write_address;
reg enable;
reg rs;
reg rw;
reg ledPrueba;
reg command_delay;
reg entry_1_finished;
reg entry_2_finished;
reg result_title_finished;
reg result_number_finished;
reg on;
reg start_writing_entries;
reg start_writing_result;
reg [6:0] cursor_address; //The bit 7 is for write address
reg [15:0] result; //register with a random result


always @ (posedge clock) // on positive clock edge
begin
 if(reset) //Initialize all the registers
  begin
   start_writing_entries = 1'b0;
	start_writing_result = 1'b0;
	write_address = 1'b0;
	entry_letter_counter = 5'b01111;
	cursor_address = 7'b0000000;
	ledPrueba = 1'b0;
	on = 1'b1;
	enable = 1'b1; 
	entry_1_finished = 1'b0;
	entry_2_finished = 1'b0;
	result_title_finished = 1'b0;
	result_number_finished = 1'b0;
	result = 16'h110f;
	
	/*
	 * We send this command from the beginning to clear the display data.
	 */
	rs = 1'b0;
	rw = 1'b0;
	lcd_data = 8'b00000001;
	command_delay = 1'b1;
	
  end
  
 else if(command_delay)
   begin
	  enable = 1'b0;
	  command_delay = 1'b0;
	  
	end 
  
 else if(show_entry_1 == 1'b1 && start_writing_entries == 1'b0 && entry_1_finished == 1'b0) //Indicates to start writing to the LCD
   begin
    start_writing_entries = 1'b1;
    write_address = 1'b1;
	 cursor_address = 7'h00;
	 ledPrueba = 1'b0;
	 
	 
   end
	
else if(show_entry_1 == 1'b0 && start_writing_result == 1'b0 && result_number_finished == 1'b0) //Indicates to start writing to the LCD
   begin
    start_writing_result = 1'b1;
    write_address = 1'b1;
	 cursor_address = 7'h00;
	 ledPrueba = 1'b0;
	 
	 /*
	 * We send this command from the beginning to clear the display data.
	 */
	rs = 1'b0;
	rw = 1'b0;
	lcd_data = 8'b00000001;
	command_delay = 1'b1;
   end
 
 else
   begin
		if(start_writing_entries)
		  begin
			if(write_address == 1'b1)
	        begin
				 rs = 1'b0;
				 rw = 1'b0;
				 enable = 1'b1; 
				 entry_1_finished = (cursor_address == 7'h10 && entry_1_finished == 1'b0) ? 1'b1 : entry_1_finished;
				 entry_2_finished = (cursor_address == 7'h50 && entry_2_finished == 1'b0) ? 1'b1 : entry_2_finished;
				 start_writing_entries =  (entry_2_finished == 1'b1) ? 1'b0 : 1'b1;
				 cursor_address = (cursor_address == 7'h10) ? 7'h40 : cursor_address;
			    cursor_address = (cursor_address == 7'h50) ? 7'h00 : cursor_address;
				 lcd_data = {1'b1, cursor_address};
				 ledPrueba = 1'b1;
				 write_address = 1'b0;
				 command_delay = 1'b1;
			  end
			else
			  begin
			    rs = 1'b1;
				 rw = 1'b0;
			    lcd_data = (entry_1[entry_letter_counter] == 1'b1) ? 8'b00110001: 8'b00110000;
				 lcd_data = (entry_1_finished == 1'b1) ? (lcd_data == 8'b00110001 ? 8'b00110000 : 8'b00110001): lcd_data;
				 entry_letter_counter = (entry_letter_counter == 5'b00000) ? 5'b01111 : entry_letter_counter - 1;
				 write_address = 1'b1;
				 cursor_address = cursor_address + 1;
				 enable = 1'b1;
				 ledPrueba = 1'b0;
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
				 result_title_finished = (cursor_address == 7'h10 && result_title_finished == 1'b0) ? 1'b1 : result_title_finished;
				 result_number_finished = (cursor_address == 7'h50 && result_number_finished == 1'b0) ? 1'b1 : result_number_finished;
				 start_writing_result =  (result_number_finished == 1'b1) ? 1'b0 : 1'b1;
				 cursor_address = (cursor_address == 7'h10) ? 7'h40 : cursor_address;
			    cursor_address = (cursor_address == 7'h50) ? 7'h00 : cursor_address;
				 lcd_data = {1'b1, cursor_address};
				 ledPrueba = 1'b1;
				 write_address = 1'b0;
				 command_delay = 1'b1;
			  end
			else
			  begin
			    rs = 1'b1;
				 rw = 1'b0;
			    lcd_data = (cursor_address == 7'h00) ? 8'b01010010: 8'b10110000;
				 lcd_data = (cursor_address == 7'h01) ? 8'b01100101: lcd_data;
				 lcd_data = (cursor_address == 7'h02) ? 8'b01110011: lcd_data;
				 lcd_data = (cursor_address == 7'h03) ? 8'b01110101: lcd_data;
				 lcd_data = (cursor_address == 7'h04) ? 8'b01101100: lcd_data;
				 lcd_data = (cursor_address == 7'h05) ? 8'b01110100: lcd_data;
				 lcd_data = (cursor_address == 7'h06) ? 8'b01100001: lcd_data;
				 lcd_data = (cursor_address == 7'h07) ? 8'b01100100: lcd_data;
				 lcd_data = (cursor_address == 7'h08) ? 8'b01101111: lcd_data;
				 lcd_data = (cursor_address == 7'h09) ? 8'b00111010: lcd_data;
				 lcd_data = (result_title_finished == 1'b1) ? ((result[entry_letter_counter] == 1'b1) ? 8'b00110001: 8'b00110000) : lcd_data;
				 entry_letter_counter = (entry_letter_counter == 5'b00000) ? 5'b01111 : entry_letter_counter - 1;
				 write_address = 1'b1;
				 cursor_address = cursor_address + 1;
				 enable = 1'b1;
				 ledPrueba = 1'b0;
				 command_delay = 1'b1;
			  end
		  end  
		else
		  begin
		   enable = 1'b1; 
	      ledPrueba = 1'b0;
		  end
   end
  
 
end

endmodule // end of module counter