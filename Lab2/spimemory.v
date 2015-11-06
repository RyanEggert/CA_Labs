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
)

wire mosi_clean;    // Conditioned MOSI signal
wire sclk_clean;    // Conditioned SCLK signal
wire cs_clean;      // Conditioned CS signal

wire sr_wren;       // Shift register write-enable
wire dm_wren;       // Data memory write-enable
wire ad_wren;       // Address latch write-enable

wire miso_en;       // MISO buffer enable

wire rs_cnt;        // FSM reset counter signal

wire[7:0] ad_data;  // Data input to the address latch
wire[7:0] ad_q;     // Data output from the address latch

wire miso_buff_in;  // Input to MISO buffer


// Create & connect three separate input conditioners. MOSI, SCLK, and CS
inputconditioner mosi_conditioner(clk, mosi_pin, mosi_clean);   // Positive edge and negative edge are unconnected
inputconditioner sclk_conditioner(clk, sclk_pin, sclk_clean, sclk_posedge, sclk_negedge); 
inputconditioner cs_conditioner(clk, cs_pin, cs_clean);         // Positive edge and negative edge are unconnected

// Create & connect data memory
datamemory spi_dm(clk, ad_q, ad_data[7:0], dm_out, dm_wren);
// Create & connect shift register
shiftregister #(8) spi_shiftreg(clk, sclk_posedge, sr_wren, dm_out, mosi_clean, ad_data, sr_serout); // ad_data is parallel out
dff miso_flipflop(clk, sr_serout, sclk_negedge, miso_buff_in);
// Create & connect finite state machine module
fsm spi_statemachine(cs_clean, sclk_clean, ad_data[0], sr_wren, rs_cnt, dm_wren, ad_wren, miso_en); //TODO: RW

assign miso_pin = (miso_en) ? miso_buff_in : 1'bz; // When the MISO buffer is enabled, output miso_buff_in from the flip-flop. Otherwise output z.

endmodule