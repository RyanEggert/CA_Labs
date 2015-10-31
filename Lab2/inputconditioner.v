//------------------------------------------------------------------------
// Input Conditioner
//    1) Synchronizes input to clock domain
//    2) Debounces input
//    3) Creates pulses at edge transitions
//------------------------------------------------------------------------

module inputconditioner
(
input 	    clk,            // Clock domain to synchronize input to
input	    noisysignal,    // (Potentially) noisy input signal
output reg  conditioned,    // Conditioned output signal
output reg  positiveedge,   // 1 clk pulse at rising edge of conditioned
output reg  negativeedge    // 1 clk pulse at falling edge of conditioned
);

    parameter counterwidth = 3; // Counter size, in bits, >= log2(waittime)
    parameter waittime = 3;     // Debounce delay, in clock cycles
    
    reg[counterwidth-1:0] counter = 0;
    reg synchronizer0 = 0;
    reg synchronizer1 = 0;
    
    always @(posedge clk ) begin
        if(conditioned == synchronizer1) // If the conditioned output is the same as the delayed input (2nd synchronizer), 
            counter <= 0;                // then nothing has changed, reset counter.
        else begin                              // However, if there has been a change,
            if( counter == waittime) begin      // and we have waited for a sufficiently long time,
                counter <= 0;                   // then reset the counter
                conditioned <= synchronizer1;   // and set a new conditioned output.
            end
            else                                // If there has been a change, but we haven't waited long enough,
                counter <= counter+1;           // then increment the counter
        end
        synchronizer0 <= noisysignal;           // Always move our noisy input to our first synchronizer
        synchronizer1 <= synchronizer0;         // and always move our first synchronizer to our second synchronizer.
    end

    always @(posedge conditioned) begin  // When conditioned output goes from 0 to 1,
        positiveedge = 1;                // assert 1 for one clock cycle (20ns).
        #20
        positiveedge = 0;
    end

    always @(negedge conditioned) begin  // When conditioned output goes from 1 to 0,
        negativeedge = 1;                // assert 1 for one clock cycle (20ns).
        #20
        negativeedge = 0;
    end
endmodule
