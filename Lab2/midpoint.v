module midpoint(
input clk,
input button0,
input switch0,
input switch1,
output[7:0] parallel_out
);

    wire            peripheralClkEdge;
    wire            parallelLoad;
    wire            serialDataOut;
    wire[7:0]       parallelDataIn;
    wire            serialDataIn; 
    
    assign parallelDataIn = 'hA5;
    wire conditioned_b0;
    wire rising_b0;

    wire rising_s0; 
    wire falling_s0;

    wire conditioned_s1;
    wire falling_s1;

    inputconditioner but0(.clk(clk),
                         .noisysignal(button0),
                         .conditioned(conditioned_b0),
                         .positiveedge(rising_b0),
                         .negativeedge(parallelLoad));

    inputconditioner swi0(.clk(clk),
                         .noisysignal(switch0),
                         .conditioned(serialDataIn),
                         .positiveedge(rising_s0),
                         .negativeedge(falling_s0));

    inputconditioner swi1(.clk(clk),
                         .noisysignal(switch1),
                         .conditioned(conditioned_s1),
                         .positiveedge(peripheralClkEdge),
                         .negativeedge(falling_s1));

    shiftregister #(8) dut(.clk(clk), 
		           .peripheralClkEdge(peripheralClkEdge),
		           .parallelLoad(parallelLoad), 
		           .parallelDataIn(parallelDataIn), 
		           .serialDataIn(serialDataIn), 
		           .parallelDataOut(parallel_out), 
		           .serialDataOut(serialDataOut));
  

endmodule
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
		if (peripheralClkEdge) begin
			shiftregistermem = shiftregistermem<<1; 
			shiftregistermem[0] = serialDataIn;
		end

		//In case of conflict, parallel changes will win because it overwrites the serial changes
		if (parallelLoad) begin
			shiftregistermem = parallelDataIn;
		end


    end

	assign parallelDataOut = shiftregistermem;
	assign serialDataOut = shiftregistermem[width-1];

endmodule


