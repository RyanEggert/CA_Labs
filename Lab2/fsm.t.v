// fsm.t.v

module testFSM();

	reg cs_pin;
	reg sclk_pin;
	reg rw;
	wire shift_wren;
	wire reset_counter;
	wire dm_wren;
	wire addr_wren;
	wire miso_en;

	reg dutpassed;
	fsm dut(.cs_pin(cs_pin),
			.sclk_pin(sclk_pin),
			.rw(rw),
			.shift_wren(shift_wren),
			.reset_counter(reset_counter),
			.dm_wren(dm_wren),
			.addr_wren(addr_wren),
			.miso_en(miso_en));

	parameter GET = 3'b000, GOT = 3'b001, READ1 = 3'b010, READ2 = 3'b011, READ3 = 3'b100, WRITE1 = 3'b101, WRITE2 = 3'b110, DONE = 3'b111;

	initial sclk_pin = 0;
	always #10 sclk_pin =! sclk_pin;

	initial begin
		// parameter cstate = testFSM.dut.current_state, nstate = testFSM.dut.next_state;
		dutpassed = 1;
		#10
		//Test 1 - if CS pin is high, remain in GET state
		$display("Starting Test 1...");
		cs_pin = 1;
		#20
		if (testFSM.dut.current_state != GET) begin 
			dutpassed = 0;
			$display("Test 1 failed: CS pin was high but the current state was not GET (0)");	
			$display("current state: %d", testFSM.dut.current_state);			
		end
		if (testFSM.dut.next_state != GET) begin
			dutpassed = 0;
			$display("Test 1 failed: CS pin was high but the next state was not GET (0)");	
			$display("next state: %d", testFSM.dut.next_state);
		end
		#200
		$display("current state: %d", testFSM.dut.current_state);

		#10
		$display("Tests complete @time = %0dns", $time);
		if (dutpassed == 1) begin
			$display("Device PASSED");
		end else begin
			$display("Device FAILED");
		end
	end
endmodule
