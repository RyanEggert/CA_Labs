// Data memory [RAM] modified from ASIC world [http://www.asic-world.com/code/hdl_models/ram_sp_sr_sw.v]
module datamemory (
clk         , // Clock Input
address     , // Address Input
data_input  , // Data input
data_output , // Data output
we          , // Write Enable/Read Enable
); 

parameter DATA_WIDTH = 8 ;
parameter ADDR_WIDTH = 7 ;

parameter RAM_DEPTH = 1 << ADDR_WIDTH;

//--------------Input Ports----------------------- 
input                  clk         ;
input [ADDR_WIDTH-1:0] address     ;
input                  we          ;
input [DATA_WIDTH-1:0] data_input  ;

output[DATA_WIDTH-1:0] data_output

//--------------Internal variables---------------- 
reg [DATA_WIDTH-1:0] data_out; // Staging for data_output
reg [DATA_WIDTH-1:0] mem [0:RAM_DEPTH-1];
reg                  oe_r;


assign data_output = (!we) ? data_out : 8'bz; // When writing, we are not reading, so set output to zzzzzzzz. Otherwise set output to data_out

// Memory Write Block 
// Write Operation : When we = 1, cs = 1
always @ (posedge clk)
begin
    if ( we ) begin
        mem[address] = data;
    end
end

// Memory Read Block 
// Read Operation : When we = 0
always @ (posedge clk)
begin
    if (!we ) begin
        data_out = mem[address];
        oe_r = 1;
    end else begin
        oe_r = 0;
    end
end

endmodule

// D flip-flop
module dff (
input clk    ,  // Clock
input data  ,   // Data Input
input ce ,      // Reset input 
output reg q        // Q data output
);

always @ ( posedge clk or negedge ce) // Note that reset is asynchronous
if (~ce) begin
  q <= 1'b0;
end  else begin
  q <= data;
end

endmodule