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

	parameter GET = 3'b000, GOT = 3'b001, READ1 = 3'b010, READ2 = 3'b011, READ3 = 3'b100, WRITE1 = 3'b101, WRITE2 = 3'b110, DONE = 3'b111;

	initial begin
		current_state = GET;
	end

//	always @(posedge reset_counter) begin
//		counter <= 4'b0000;
//	end


    always @(posedge sclk_pin) begin
        if (reset_counter == 1) begin
            counter <= 4'b0;
        end else begin
            counter <= counter + 1;
        end
    end
    
	always @(posedge clk) begin
		if (cs_pin == 1) begin
			current_state <= GET;
			reset_counter <= 1;
		end
		else begin
			case(current_state)
			GET:	begin 
						if (counter == 8) begin
							current_state <= GOT;
						end
						else if (sclk_pin) begin
							current_state <= GET;
							reset_counter <= 0;
						end
					end
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
			READ1:	begin
						reset_counter <= 0;
						addr_wren <= 0;
						current_state <= READ2;
					end
			READ2:	begin
						shift_wren <= 1;
						current_state <= READ3;
					end
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
			WRITE1:	begin
						miso_en <= 0;
						if (counter == 8) begin
							current_state <= WRITE2;
						end
						else if (sclk_pin) begin
							current_state <= WRITE1;
						end
					end
			WRITE2:	begin
						dm_wren <= 1;
						current_state <= DONE;	
					end
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