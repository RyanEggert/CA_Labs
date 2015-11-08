//------------------------------------------------------------------------
// SPI Memory
//------------------------------------------------------------------------

module spiMemory
(
    input           clk,        // FPGA clock
    input           sclk_pin,   // SPI clock
    input           cs_pin,     // SPI chip select
    output          miso_pin,   // SPI master in slave out
    input           mosi_pin,   // SPI master out slave in
    input           fault_pin,  // For fault injection testing
    output [3:0]    leds        // LEDs for debugging
);

wire mosi_clean;    // Conditioned MOSI signal
wire sclk_clean;    // Conditioned SCLK signal
wire cs_clean;      // Conditioned CS signal

wire sr_wren;       // Shift register write-enable
wire dm_wren;       // Data memory write-enable
wire ad_wren;       // Address latch write-enable

wire miso_en;       // MISO buffer enable

wire rs_cnt;        // FSM reset counter signal

wire[7:0] ad_data;  // Data input to the address latch
reg[7:0] ad_q;     // Data output from the address latch

reg miso_buff_in;  // Input to MISO buffer


// Create & connect three separate input conditioners. MOSI, SCLK, and CS
inputconditioner mosi_conditioner(.clk(clk),
									.noisysignal(mosi_pin),
									.conditioned(mosi_clean));   // Positive edge and negative edge are unconnected

inputconditioner sclk_conditioner(.clk(clk),
									.noisysignal(sclk_pin),
									.conditioned(sclk_clean),
									.positiveedge(sclk_posedge),
									.negativeedge(sclk_negedge));

inputconditioner cs_conditioner(.clk(clk),
								.noisysignal(cs_pin),
								.conditioned(cs_clean));         // Positive edge and negative edge are unconnected

// Create & connect data memory
datamemory spi_dm(.clk(clk),
					.dataOut(dm_out),
					.address(ad_q[7:1]),
					.writeEnable(dm_wren),
					.dataIn(ad_data));

// Create & connect shift register
shiftregister #(8) spi_shiftreg(.clk(clk),
								.peripheralClkEdge(sclk_posedge),
								.parallelLoad(sr_wren),
								.parallelDataIn(dm_out),
								.serialDataIn(mosi_clean),
								.parallelDataOut(ad_data),
								.serialDataOut(sr_serout)); // ad_data is parallel out

// dff miso_flipflop(clk, sr_serout, sclk_negedge, miso_buff_in);		//replaced with if statement in clk below

// Create & connect finite state machine module
fsm spi_statemachine(.cs_pin(cs_clean),
						.clk(clk),
						.sclk_pin(sclk_clean),
						.rw(ad_q[0]),
						.shift_wren(sr_wren),
						.reset_counter(rs_cnt),
						.dm_wren(dm_wren),
						.addr_wren(ad_wren),
						.miso_en(miso_en)); //TODO: RW

assign miso_pin = (miso_en) ? miso_buff_in : 1'bz; // When the MISO buffer is enabled, output miso_buff_in from the flip-flop. Otherwise output z.

always @(posedge clk) begin
	//address latch
	if (ad_wren) begin
		ad_q <= ad_data;
	end
	//dff miso_flipflop
	if (sclk_negedge) begin
		miso_buff_in <= sr_serout;
	end
end

endmodule