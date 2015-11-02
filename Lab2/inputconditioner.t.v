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
        #1
        if (conditioned != 1) begin
            dutpassed = 0;
            $display("Test 2 failed: conditioned signal != 1 at time %0dns", $time);
            $display("    [conditioned = %b]", conditioned);
        end else begin
            $display("PASS");
        end
        #9


        // Test 3 - test synchronization
        $display("Starting Test 3 @time = %0dns...", $time);
        #4
        pin = 0;
        #6
        #100
        #1
        if (conditioned != 0) begin
            dutpassed = 0;
            $display("Test 3 failed: conditioned signal != 1 at time %0dns", $time);
            $display("    [conditioned = %b]", conditioned);

        end else begin
            $display("PASS");
        end
        #9
        #100


        // Test 4 - test debounce
        $display("Starting Test 4 @time = %0dns...", $time);
        pin = 1;
        #20
        pin = 0;
        #80
        #1
        if (conditioned != 0) begin
            dutpassed = 0;
            $display("Test 4 failed: conditioned signal != 1 at time %0dns", $time);
            $display("    [conditioned = %b]", conditioned);

        end else begin
            $display("PASS");
        end
        #9

        // Test 5 - test debounce
        $display("Starting Test 5 @time = %0dns...", $time);
        pin = 1;
        #46
        pin = 0;
        #34
        #1
        if (conditioned != 0) begin
            dutpassed = 0;
            $display("Test 5 failed: conditioned signal != 1 at time %0dns", $time);
            $display("    [conditioned = %b]", conditioned);

        end else begin
            $display("PASS");
        end
        #9
        #20
        // Test 6 - test positive edge detection
        $display("Starting Test 6 @time = %0dns...", $time);
        pin = 1;
        #110
        #1
        if (rising != 1 || falling != 0) begin
            dutpassed = 0;
            $display("Test 6 failed @time %0dns", $time);
            $display("    [rising = %b]", rising);
        end else begin
            $display("PASS");
        end
        #9

        // Test 7 - test debounce
        $display("Starting Test 7 @time = %0dns...", $time);
        pin = 0;
        #110
        #1
        if (falling != 1 || rising != 0) begin
            dutpassed = 0;
            $display("Test 7 failed");
            $display("    [falling = %b]", conditioned);

        end else begin
            $display("PASS");
        end
        #9

        #10
        $display("Tests Complete @time = %0dns.", $time);
        if (dutpassed == 1) begin
            $display("Device PASSED");
        end else begin
            $display("Device FAILED");
        end
    end
    
endmodule