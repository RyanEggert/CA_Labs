//--------------------------------------------------------------------------------
// Main Lab 2 wrapper module
//   Interfaces with switches, buttons, and LEDs on ZYBO board. 
//
//--------------------------------------------------------------------------------

module lab2_wrapper
(
    input        clk,
    input  [1:0] sw,
    input  [0:0] btn,
    output [3:0] led
);
    
    wire[7:0] pout;       // parallel output
    
    //  midpoint file
    midpoint mptdel(.clk(clk), .button0(btn[0]), .switch0(sw[0]), .switch1(sw[1]), .parallel_out(pout));

    // Assign bits of second display output to show carry out and overflow
    assign led = pout[3:0];
    
endmodule