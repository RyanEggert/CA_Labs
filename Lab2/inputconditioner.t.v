//------------------------------------------------------------------------
// Input Conditioner test bench
//------------------------------------------------------------------------

module testConditioner();

    reg clk;
    reg pin;
    wire conditioned;
    wire rising;
    wire falling;
    
    reg dutpassed;
    inputconditioner dut(.clk(clk),
                         .noisysignal(pin),
                         .conditioned(conditioned),
                         .positiveedge(rising),
                         .negativeedge(falling));


    // Generate clock (50MHz)
    initial clk=0;
    always #10 clk=!clk;    // 50MHz Clock
    
    initial begin
        dutpassed = 1;
        // Your Test Code
        // Be sure to test each of the three conditioner functions:
        // Synchronize, Clean, Preprocess (edge finding)
        #10
        // Test 1
        $display("Running Test 1...");
        pin = 0;
        #60
        if (conditioned != 0) begin
            dutpassed = 0;
            $display("Test 1 failed: unexpected conditioned signal");
        end else begin
            $display("PASS");
        end

        // Test 2
        $display("Running Test 2...");
        pin = 1;
        #60
        if (conditioned != 1) begin
            dutpassed = 0;
            $display("Test 2 failed: conditioned signal != 1");
        end else begin
            $display("PASS");
        end

        #10
        if (dutpassed == 1) begin
            $display("Device PASSED");
        end else begin
            $display("Device FAILED");
        end
    end
    
endmodule