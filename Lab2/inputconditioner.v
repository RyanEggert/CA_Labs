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

    parameter counterwidth = 4; // Counter size, in bits, >= log2(waittime)
    parameter waittime = 10;     // Debounce delay, in clock cycles
    
    reg[counterwidth-1:0] counter = 0;
    reg synchronizer0 = 0;
    reg synchronizer1 = 0;
    
    always @(posedge clk ) begin
        if(conditioned == synchronizer1) begin  // If the conditioned output is the same as the delayed input (2nd synchronizer), 
            counter <= 0;                       // then nothing has changed, reset counter.
            positiveedge <= 0;
            negativeedge <= 0;
        end                                     
        else begin                              // However, if there has been a change,
            if( counter == waittime) begin      // and we have waited for a sufficiently long time, then we should change our conditioned output.
                if (synchronizer1 > conditioned) begin  // Check whether our signal has moved from low -> high.
                    positiveedge <= 1;                  // If it has, assert positive edge
                end else begin
                    negativeedge <= 1;                  // If it hasn't, assert negative edge [i.e. high -> low]
                end
                counter <= 0;                   // Next reset the counter
                conditioned <= synchronizer1;   // and set a new conditioned output.
            end
            else                                // If there has been a change, but we haven't waited long enough,
                counter <= counter+1;           // then increment the counter
        end
        synchronizer0 <= noisysignal;           // Always move our noisy input to our first synchronizer
        synchronizer1 <= synchronizer0;         // and always move our first synchronizer to our second synchronizer.
    end
endmodule
