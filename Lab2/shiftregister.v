//------------------------------------------------------------------------
// Shift Register
//   Parameterized width (in bits)
//   Shift register can operate in two modes:
//      - serial in, parallel out
//      - parallel in, serial out
//------------------------------------------------------------------------

module shiftregister
#(parameter width = 8)
(
input               clk,                // FPGA Clock
input               peripheralClkEdge,  // Edge indicator
input               parallelLoad,       // 1 = Load shift reg with parallelDataIn
input  [width-1:0]  parallelDataIn,     // Load shift reg in parallel
input               serialDataIn,       // Load shift reg serially
output [width-1:0]  parallelDataOut,    // Shift reg data contents
output              serialDataOut       // Positive edge synchronized
);

    reg [width-1:0]      shiftregistermem;
    

    always @(posedge clk) begin
		//serial load when peripheralClkEdge is up
		if (peripheralClkEdge) begin
			shiftregistermem = shiftregistermem<<1; 
			shiftregistermem[0] = serialDataIn;
		end
		
		//parallel load when parallel load is up
		if (parallelLoad) begin
			shiftregistermem = parallelDataIn;
		end
		//In case of conflict, parallel changes will win because it overwrites the serial changes
		

    end

    // always update parallel out and serial out
	assign parallelDataOut = shiftregistermem;
	assign serialDataOut = shiftregistermem[width-1];

endmodule


