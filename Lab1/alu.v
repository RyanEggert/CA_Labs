`define ADD  3'd0
`define SUB  3'd1
`define XOR  3'd2
`define SLT  3'd3
`define AND  3'd4
`define NAND 3'd5
`define NOR  3'd6
`define OR   3'd7

module ALU
(
output[31:0]    result,
output          carryout,
output          zero,
output          overflow,
input[31:0]     operandA,
input[31:0]     operandB,
input[2:0]      command
);

wire[33:0] ADD_out;
wire[33:0] SUB_out;

wire[33:0] SLT_out;

wire[33:0] XOR_out;
wire[33:0] AND_out;
wire[33:0] NAND_out;
wire[33:0] OR_out;
wire[33:0] NOR_out;



// Create and wire adder/subtractor
// Output bus wires 0-31 contain output, wire 32 is carryout, wire 33 is overflow
FullAdder32bit ADD_module(ADD_out[31:0], ADD_out[32], ADD_out[33], operandA, operandB);
// Create and wire SLT

// Create and wire AND

// Create and wire OR

// Create and wire XOR

// Create and wire NAND

// Create and wire NOR

// For logical + SLT outputs, add false carryout and overflow bits
// Do I need the below? If I only set the first 32 bits, are bits 33 and 34 by default 0?

assign SLT_out[33:32] = 2'b00;
assign XOR_out[33:32] = 2'b00;
assign AND_out[33:32] = 2'b00;
assign NAND_out[33:32] = 2'b00;
assign OR_out[33:32] = 2'b00;
assign NOR_out[33:32] = 2'b00;

endmodule

module ALUcontrolLUT
(
output reg[33:0] out,
input[33:0] in_ADD,
input[33:0] in_SUB,
input[33:0] in_SLT,
input[33:0] in_XOR,
input[33:0] in_AND,
input[33:0] in_NAND,
input[33:0] in_OR,
input[33:0] in_NOR,
input[2:0]  ALUcommand
);

  always @(ALUcommand) begin
    case (ALUcommand)
      `ADD:  begin out = in_ADD; end    
      `SUB:  begin out = in_SUB; end  
      `XOR:  begin out = in_XOR; end      
      `SLT:  begin out = in_SLT; end  
      `AND:  begin out = in_AND; end      
      `NAND: begin out = in_NAND; end  
      `NOR:  begin out = in_NOR; end      
      `OR:   begin out = in_OR; end  
    endcase
  end
endmodule


module test_ALUcontrolLUT;
wire[33:0] out;
reg[33:0] in_ADD;
reg[33:0] in_SUB;
reg[33:0] in_SLT;
reg[33:0] in_XOR;
reg[33:0] in_AND;
reg[33:0] in_NAND;
reg[33:0] in_OR;
reg[33:0] in_NOR;
reg[2:0]  ALUcommand;
ALUcontrolLUT testALUlut(out, in_ADD, in_SUB, in_SLT, in_XOR, in_AND, in_NAND, in_NOR, in_OR, ALUcommand);

initial begin
// Can I select an input?
$display("                                    Inputs                                    |                Output              |");
$display("CMD | in_ADD                             | in_NOR                             | Mux Output                         |");
ALUcommand=`ADD; in_ADD=34'b0111010000111010010011110100100101;  #1000
$display("%b | %b | %b | %b |", ALUcommand, in_ADD, in_NOR, out);
//more to come
end
endmodule