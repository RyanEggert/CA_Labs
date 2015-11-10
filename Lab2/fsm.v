module fsm
#(parameter width = 8)
(
	input 		cs_pin,				//chip select
	input		clk,				//fast clock
	input 		sclk_pin,			//slow clock -- used for counter increment b/c it is high when data comes in on the shift register
	input 		rw,					//read/write; the 8th bit coming out of the parallel out on the shift register (aka shift register out p0)
	output reg	shift_wren,			//shift register write enable
	output reg 	reset_counter,		//reset counter
	output reg 	dm_wren,			//data memory write enable
	output reg 	addr_wren,			//address write enable
	output reg 	miso_en				//master in, slave out enable

);

	reg [width-1:0]     current_state;		//Massachusetts
	reg [3:0]			counter;			//counter to count up to 8 bits before action (used in GET, WRITE1, READ3)

	//mapping the state names to numbers (d0-d7)
	parameter GET = 3'b000, GOT = 3'b001, READ1 = 3'b010, READ2 = 3'b011, READ3 = 3'b100, WRITE1 = 3'b101, WRITE2 = 3'b110, DONE = 3'b111;

	initial begin
		current_state = GET;				//always start in GET (0) state
	end

    always @(posedge sclk_pin) begin 		//on the high edge of the slow clock
        if (reset_counter == 1) begin 		//if the reset counter is high
            counter <= 4'b0;				//set the counter value to be 0
        end else begin
            counter <= counter + 1;			//if the reset counter is NOT high, add one to the counter
        end
    end
    
	always @(posedge clk) begin 			//on the high edge of the fast clock
		if (cs_pin == 1) begin 				//if the chip select is high
			current_state <= GET;			//change the current state to GET (0)
			reset_counter <= 1;				//and set the reset counter to high
		end
		else begin 							//if the chip select is low, go through the case statements
			case(current_state)

			//we start in the GET state at the beginning of the code;
			//we stay in the GET state if the counter is less than 8 and the slow clock is on
			//we leave and move on to the GOT state when the counter is 8
			GET:	begin 
						if (counter == 8) begin
							current_state <= GOT;
						end
						else if (sclk_pin) begin
							current_state <= GET;
							reset_counter <= 0;
						end
					end

			//each time we enter the GOT state, we set the reset counter high and the address write enable high
			//we move from GOT to READ1 if the read/write is high
			//if the read/write is low, we move to WRITE1
			GOT: 	begin
						reset_counter <= 1;
						addr_wren <= 1;
						if (rw == 1) begin
							current_state <= READ1;
						end
						else begin
							current_state <= WRITE1;
						end
					end

			//each time we enter the READ1 state, we set the reset counter low and the address write enable low
			//we always move from READ1 to READ2 in the next clock cycle
			READ1:	begin
						reset_counter <= 0;
						addr_wren <= 0;
						current_state <= READ2;
					end

			//each time we enter the READ2 state, we set the shift register write enable high
			//we always move from READ2 to READ3 in the next clock cycle
			READ2:	begin
						shift_wren <= 1;
						current_state <= READ3;
					end

			//each time we enter the READ3 state, we set the shift register write enable low and the master in, slave out enable high
			//we stay in the READ3 state if the counter is less than 8 and the slow clock is on
			//we leave and move on to the DONE state when the counter is 8
			READ3:	begin
						shift_wren <= 0;
						miso_en <= 1;
						if (counter == 8) begin
							current_state <= DONE;
						end
						else if (sclk_pin) begin
							current_state <= READ3;
						end
					end

			//each time we enter the WRITE1 state, we set the master in, slave out low
			//we stay in the WRITE1 state if the counter is less than 8 and the slow clock is on
			//we leave and move on to the WRITE2 state when the counter is 8
			WRITE1:	begin
						miso_en <= 0;
						if (counter == 8) begin
							current_state <= WRITE2;
						end
						else if (sclk_pin) begin
							current_state <= WRITE1;
						end
					end
			
			//each time we enter the WRITE2 state, we set the data memory write enable high
			//we always move from WRITE2 to DONE in the next clock cycle
			WRITE2:	begin
						dm_wren <= 1;
						current_state <= DONE;	
					end

			//each time we enter the DONE state, we set the data memory write enable low and the reset counter high
			//if the chip select is high, we move to the GET state
			//we stay in the DONE state if the chip select is low
			DONE:	begin
						dm_wren <= 0;
						reset_counter <= 1;
						if (cs_pin == 1) begin
							current_state <= GET;
						end
						else begin
							current_state <= DONE;
						end
					end
			endcase
		end
	end

endmodule