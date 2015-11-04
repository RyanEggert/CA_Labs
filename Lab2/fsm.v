module finite_state_machine
#(parameter width = 8)
(
	input 		cs_pin,				//chip select
	input 		sclk_pin,			//s clock
	input 		rw,					//read/write; the 8th bit coming out of the parallel out on the shift register (aka shift register out p0)
	output reg	shift_wren,			//shift register write enable
	output reg 	reset_counter,		//reset counter
	output reg 	dm_wren,			//data memory write enable
	output reg 	addr_wren,			//address write enable
	output reg 	miso_en				//master in, slave out enable

);

	reg [width-1:0]     current_state;		//Massachusetts
	reg [width-1:0]		next_state;			//"Wisconsin is the future"	-Ryan
	reg [2:0]			counter;			//counter to count up to 8 bits before action (used in GET, WRITE1, READ3)

	parameter GET = 3'b000, GOT = 3'b001, READ1 = 3'b010, READ2 = 3'b011, READ3 = 3'b100, WRITE1 = 3'b101, WRITE2 = 3'b110, DONE = 3'b111;

	always @(posedge reset_counter) begin
		counter <= 3'b000;
	end

	always @(posedge sclk_pin) begin
		if (cs_pin == 1) begin
			next_state <= GET;
			reset_counter <= 1;
		end
		else begin
			case(current_state)
			GET:	begin 
						if (counter == 8) begin
							next_state <= GOT;
							reset_counter <= 0;			//definitely does not reset our counter
						end
						else begin
							next_state <= GET;
							counter <= counter + 1;
						end
					end
			GOT: 	begin
						reset_counter <= 1;
						addr_wren <= 1;
						if (rw == 1) begin
							next_state <= READ1;
						end
						else begin
							next_state <= WRITE1;
						end
					end
			READ1:	begin
						reset_counter <= 0;
						addr_wren <= 0;
						next_state <= READ2;
					end
			READ2:	begin
						shift_wren <= 1;
						next_state <= READ3;
					end
			READ3:	begin
						shift_wren <= 0;
						miso_en <= 1;
						if (counter == 8) begin
							next_state <= DONE;
						end
						else begin
							next_state <= READ3;
							counter <= counter + 1;
						end
					end
			WRITE1:	begin
						miso_en <= 0;
						if (counter == 8) begin
							next_state <= WRITE2;
						end
						else begin
							next_state <= WRITE1;
							counter <= counter + 1;
						end
					end
			WRITE2:	begin
						dm_wren <= 1;
						next_state <= DONE;	
					end
			DONE:	begin
						dm_wren <= 0;
						reset_counter <= 1;
						if (cs_pin == 1) begin
							next_state <= GET;
						end
						else begin
							next_state <= DONE;
						end
					end
			endcase
			current_state <= next_state;
		end
	end

endmodule