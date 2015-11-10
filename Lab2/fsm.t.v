// fsm.t.v
module testFSM();

	reg cs_pin;
	reg clk;
	reg sclk_pin;
	reg rw;
	wire shift_wren;
	wire reset_counter;
	wire dm_wren;
	wire addr_wren;
	wire miso_en;

	reg dutpassed;

	//creating an fsm called dut with all the characteristics of an fsm
	fsm dut(.cs_pin(cs_pin),
			.clk(clk),
			.sclk_pin(sclk_pin),
			.rw(rw),
			.shift_wren(shift_wren),
			.reset_counter(reset_counter),
			.dm_wren(dm_wren),
			.addr_wren(addr_wren),
			.miso_en(miso_en));

	parameter GET = 3'b000, GOT = 3'b001, READ1 = 3'b010, READ2 = 3'b011, READ3 = 3'b100, WRITE1 = 3'b101, WRITE2 = 3'b110, DONE = 3'b111;

	initial sclk_pin = 0;				//initialize the slow clock to zero
	initial clk = 0;					//initialize the fast clock to zero
	always #100 sclk_pin =! sclk_pin;	//build the slow clock: every 100 nanoseconds, NOT the state of the slow clock to make it tick
	always #10 clk =! clk;				//create the fast clock; every 10 nanoseconds, NOT the state of the fast clock to make it tick

	initial begin
		dutpassed = 1;		//set the passing condition intitally to 1; if it fails anywhere in the initial block, it will be set to 0
		#20 				//initial delay to allow everything to get set up

		//begin read path testing
		$display("----------------------------------");
		$display("Testing Read Path...");

		//Test 1 - if CS pin is high, remain in GET state
		$display("Starting Test 1... (steady GET)");
		cs_pin = 1;
		#20 				//delay to allow chip select set to high to take effect

		if (testFSM.dut.current_state != GET) begin 
			dutpassed = 0;		//alert that the device failed
			$display("Test 1 failed: CS pin set high, but the current state is not GET (0)");	
			$display("current state: %d", testFSM.dut.current_state);			
		end

		#1600	//delay to allow it to go to GOT if it's planning on going anywhere
		if (testFSM.dut.current_state != GET) begin 
			dutpassed = 0;
			$display("Test 1 failed: CS pin set high, but the current state is not GET (0)");	
			$display("current state: %d", testFSM.dut.current_state);
		end

		//Test 2 - if CS is low, we should be in GET; then after 8 cycles we should be in GOT
		$display("Starting Test 2... (GET --> GOT)");
		cs_pin = 0;		//set the chip select low after it was high for test 1
		#20
		if (testFSM.dut.current_state != GET) begin
			dutpassed = 0;
			$display("Test 2 failed: CS pin set from high to low with no delay, but the current state is not GET (0)");
			$display("current_state: %d", testFSM.dut.current_state);
		end
	
		#1660	//delay to switch states to next state
		if (testFSM.dut.current_state != GOT) begin
			dutpassed = 0;
			$display("Test 2 failed: CS pin set from high to low with proper delay, but the current state is not GOT (1)");
			$display("current_state: %d", testFSM.dut.current_state);
		end

		//Test 3 - if read/write is on, we should be in READ1
		$display("Starting Test 3... (GOT --> READ1)");
		rw = 1;			//set the read/write high to change to READ1 state
		#20
		if (testFSM.dut.current_state != READ1) begin
			dutpassed = 0;
			$display("Test 3 failed: Read/Write set high, but the current state is not READ1 (2)");
			$display("current_state: %d", testFSM.dut.current_state);
		end

		//Test 4 - a single clock cycle from READ1 should take us to READ2
		$display("Starting Test 4... (READ1 --> READ2)");
		#20
		if (testFSM.dut.current_state != READ2) begin
			dutpassed = 0;
			$display("Test 4 failed: A clock cycle passed in READ1, but the current state is not READ2 (3)");
			$display("current_state: %d", testFSM.dut.current_state);
		end
		
		//Test 5 - a single clock cycle from READ2 should take us to READ3
		$display("Starting Test 5... (READ2 --> READ3)");
		#20
		if (testFSM.dut.current_state != READ3) begin
			dutpassed = 0;
			$display("Test 5 failed: A clock cycle passed in READ2, but the current state is not READ3 (4)");
			$display("current_state: %d", testFSM.dut.current_state);
		end

		//Test 6 - Delay 8 clock cycles, then we should be in DONE
		$display("Starting Test 6... (READ3 --> DONE)");
		#1600		//with a short clock cycle of 100 nanoseconds, a full cycle is 200 nanoseconds and we need to wait 8 cycles; 200 * 8 = 1600 nanosecond delay
		if (testFSM.dut.current_state != DONE) begin
			dutpassed = 0;
			$display("Test 6 failed: Eight clock cycles passed in READ3, but the current state is not DONE (7)");
			$display("current_state: %d", testFSM.dut.current_state);
		end

		//Test 7 - a delay after DONE shouldn't move anywhere
		$display("Starting Test 7... (steady DONE)");
		#1600
		if (testFSM.dut.current_state != DONE) begin
			dutpassed = 0;
			$display("Test 7 failed: The chip select remained low, but the current state did not remain in DONE (7)");
			$display("current_state: %d", testFSM.dut.current_state);
		end

		//Test 8 - Set chip select high, then we should go back to GET
		$display("Starting Test 8... (DONE --> GET)");
		cs_pin = 1;		//setting chip select high should send us back to GET
		#200
		if (testFSM.dut.current_state != GET) begin
			dutpassed = 0;
			$display("Test 8 failed: The chip select was set high, but the current state is not GET (0)");
			$display("current_state: %d", testFSM.dut.current_state);
		end

		//results of the read path
		#100
		if (dutpassed == 1) begin
			$display("Read path PASSED");
		end else begin
			$display("Read path FAILED");
		end

		//begin write path testing
		$display("----------------------------------");
		$display("Testing Write Path...");
		
		//Test 1 - if CS pin is high, remain in GET state
		$display("Starting Test 1... (steady GET)");
		cs_pin = 1;		//set chip select high
		#200
		if (testFSM.dut.current_state != GET) begin 
			dutpassed = 0;
			$display("Test 1 failed: CS pin set high, but the current state is not GET (0)");	
			$display("current state: %d", testFSM.dut.current_state);			
		end

		#1600	//delay to allow it to go to GOT if it's planning on going anywhere
		if (testFSM.dut.current_state != GET) begin 
			dutpassed = 0;
			$display("Test 1 failed: CS pin set high, but the current state is not GET (0)");	
			$display("current state: %d", testFSM.dut.current_state);
		end

		//Test 2 - if CS is low, we should be in GET; then after 8 cycles we should be in GOT
		$display("Starting Test 2... (GET --> GOT)");
		cs_pin = 0;		//set chip select low
		#20
		if (testFSM.dut.current_state != GET) begin
			dutpassed = 0;
			$display("Test 2 failed: CS pin set from high to low with no delay, but the current state is not GET (0)");
			$display("current_state: %d", testFSM.dut.current_state);
		end
	
		#1630	//delay to switch states to next state
		if (testFSM.dut.current_state != GOT) begin
			dutpassed = 0;
			$display("Test 2 failed: CS pin set from high to low with proper delay, but the current state is not GOT (1)");
			$display("current_state: %d", testFSM.dut.current_state);
		end

		//Test 3 - if read/write low, go to WRITE1
		$display("Starting Test 3... (GOT --> WRITE1)");
		rw = 0;		//set the read/write low to change to WRITE1 state
		#20
		if (testFSM.dut.current_state != WRITE1) begin
			dutpassed = 0;
			$display("Test 3 failed: Read/Write set low, but current state not WRITE1 (5)");
			$display("current_state: %d", testFSM.dut.current_state);
		end

		//Test 4 - Delay 8 clock cycles, then we should be in WRITE2
		$display("Starting Test 4... (WRITE1 --> WRITE2)");
		#20		
		if (testFSM.dut.current_state != WRITE2) begin
			dutpassed = 0;
			$display("Test 4 failed: Eight clock cycles passed in WRITE1, but the current state is not WRITE2 (6)");
			$display("current_state: %d", testFSM.dut.current_state);
		end

		//Test 5 - a single clock cycle from WRITE2 should take us to DONE
		$display("Starting Test 5... (WRITE2 --> DONE)");
		#20
		if (testFSM.dut.current_state != DONE) begin
			dutpassed = 0;
			$display("Test 5 failed: A clock cycle passed in WRITE2, but the current state is not DONE (7)");
			$display("current_state: %d", testFSM.dut.current_state);
		end

		//Test 6 - a delay after DONE shouldn't move anywhere
		$display("Starting Test 6... (steady DONE)");
		#1600
		if (testFSM.dut.current_state != DONE) begin
			dutpassed = 0;
			$display("Test 6 failed: The chip select remained low, but the current state did not remain in DONE (7)");
			$display("current_state: %d", testFSM.dut.current_state);
		end

		//results of the write path
		#100
		if (dutpassed == 1) begin
			$display("Write path PASSED");
		end else begin
			$display("Write path FAILED");
		end
		$display("----------------------------------");

		//The end!
		#100
		$display("Tests complete @time = %0dns", $time);
		if (dutpassed == 1) begin
			$display("Device PASSED");
		end else begin
			$display("Device FAILED");
		end
		$display("----------------------------------");
	end
endmodule
