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
        $display("Starting Test 1 @time = %0dns...", $time);
        pin = 0;
        #60
        if (conditioned != 0) begin
            dutpassed = 0;
            $display("Test 1 failed: unexpected conditioned signal at time %0dns", $time);
        end else begin
            $display("PASS");
        end

        // Test 2
        $display("Starting Test 2 @time = %0dns...", $time);
        pin = 1;
        #100
        if (conditioned != 1) begin
            dutpassed = 0;
            $display("Test 2 failed: conditioned signal != 1 at time %0dns", $time);
            $display("    [conditioned = %b]", conditioned);
        end else begin
            $display("PASS");
        end


        // Test 3
        $display("Starting Test 3 @time = %0dns...", $time);
        #4
        pin = 0;
        #6
        #100
        if (conditioned != 0) begin
            dutpassed = 0;
            $display("Test 3 failed: conditioned signal != 1 at time %0dns", $time);
            $display("    [conditioned = %b]", conditioned);

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