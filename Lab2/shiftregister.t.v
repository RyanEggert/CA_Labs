//------------------------------------------------------------------------
// Shift Register test bench
//------------------------------------------------------------------------

module testshiftregister();

    reg             clk;
    reg             peripheralClkEdge;
    reg             parallelLoad;
    wire[7:0]       parallelDataOut;
    wire            serialDataOut;
    reg[7:0]        parallelDataIn;
    reg             serialDataIn; 
    
    // Instantiate with parameter width = 8
    shiftregister #(8) dut(.clk(clk), 
    		           .peripheralClkEdge(peripheralClkEdge),
    		           .parallelLoad(parallelLoad), 
    		           .parallelDataIn(parallelDataIn), 
    		           .serialDataIn(serialDataIn), 
    		           .parallelDataOut(parallelDataOut), 
    		           .serialDataOut(serialDataOut));
    
    initial clk=0;
    always #10 clk=!clk;    // 50MHz Clock
    
    initial begin
    
    $display("Test Case 0: Full set to 0");

    parallelDataIn = 8'd0; 
    parallelLoad = 1;
    #40
    parallelLoad = 0;
    
    if (parallelDataOut != 8'd0 || serialDataOut!= 0)
        $display("Test Case 0 Failed");
    
    $display("Test Case 1: Serial In");
    
    serialDataIn = 1;
    peripheralClkEdge = 1;
    #20
    peripheralClkEdge = 0;
    #20
    serialDataIn = 0;
    #20
    peripheralClkEdge = 1;
    #20
    serialDataIn = 1;
    #20
    peripheralClkEdge = 0;
    #20
    serialDataIn = 0;
    #20
    peripheralClkEdge = 1;
    #20
    peripheralClkEdge = 0;

    // Added 1, 0, 1, 0 to the shift register through serial input, checking that they were saved correctly in order and MSB is correct
    if (parallelDataOut != 8'd10 || serialDataOut!= 0)
        $display("Test Case 1 Failed");
    
    #80
    
    // Added 1, 0, 1, 0 to the shift register through serial input, checking that they were saved correctly in order and MSB is correct
    if (parallelDataOut != 8'd10 || serialDataOut!= 1)
        $display("Test Case 1 Failed");
    
    parallelDataIn = 8'd0; 
    parallelLoad = 1;
    #40
    
    $display("Test Case 2: Parallel In");

    parallelDataIn = 8'd128;
    parallelLoad = 1;
    #20
    //Checking that MSB/SDO is correctly set to 1 and parallel load correcly loaded the shift register
    if (parallelDataOut != 8'd128 || serialDataOut != 1)
        $display("Test Case 2 Failed");
    parallelDataIn = 8'd127;
    parallelLoad = 1;
    #20

    //Checking that MSB/SDO is correctly set to 0 and parallel load correcly loaded the shift register
    if (parallelDataOut != 8'd127 || serialDataOut != 0)
        $display("Test Case 2 Failed");


    //Test Case 3
    $display("Test Case 3: Conflict of Serial and Parallel");
    peripheralClkEdge = 1;
    parallelLoad = 1;
    parallelDataIn = 8'd255;
    serialDataIn = 0;
    #20

    //Parallel data in should win. We chose this case because you don't lose as much data.
    if (parallelDataOut != 8'd255 || serialDataOut != 1)
        $display("Test Case 3 Failed");

    parallelLoad = 0;
    #80
    //If we turn the parallel load off, the serial data starts coming back in again
    if (parallelDataOut != 8'd240 || serialDataOut != 1)
        $display("Test Case 3 Failed");


    end

endmodule

