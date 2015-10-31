`define ADD  3'd0
`define SUB  3'd1
`define XOR  3'd2
`define SLT  3'd3
`define AND  3'd4
`define NAND 3'd5
`define NOR  3'd6
`define OR   3'd7

`define GT_NOR32 nor #320 // One 32-input NOR gate with appropriate delay.

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

wire[33:0] MUX_out;

// Create and wire ADD
// Output bus wires 0-31 contain output, wire 32 is carryout, wire 33 is overflow
FullAdder32bit ADD_module(ADD_out[31:0], ADD_out[32], ADD_out[33], operandA, operandB);
// Create and wire SUB
FullSubtractor32bit SUB_module(SUB_out[31:0], operandA, operandB);
// Create and wire SLT
setlessthan SLT_module(SLT_out[31:0], operandA, operandB);
// Create and wire AND
AND32Bit AND_module(AND_out[31:0], operandA, operandB);
// Create and wire OR
Or32Bit OR_module(OR_out[31:0], operandA, operandB);
// Create and wire XOR
Xor32Bit XOR_module(XOR_out[31:0], operandA, operandB);
// Create and wire NAND
NAND32Bit NAND_module(NAND_out[31:0], operandA, operandB);
// Create and wire NOR
Nor32Bit NOR_module(NOR_out[31:0], operandA, operandB);
// For logical + SLT outputs, add false carryout and overflow bits
// Do I need the below? If I only set the first 32 bits, are bits 33 and 34 by default 0?

assign SLT_out[33:32] = 2'b00;
assign XOR_out[33:32] = 2'b00;
assign AND_out[33:32] = 2'b00;
assign NAND_out[33:32] = 2'b00;
assign OR_out[33:32] = 2'b00;
assign NOR_out[33:32] = 2'b00;

// Create and wire control multiplexer
ALUcontrolLUT ALU_MUX(MUX_out, ADD_out, SUB_out, SLT_out, XOR_out, AND_out, NAND_out, OR_out, NOR_out, command);

// Connect result output to section MUX output bus
assign result = MUX_out[31:0];

// Use 32-input OR-gate to raise `zero` flag based on result (MUX_out [31:0])
`GT_NOR32 zeroOR(zero, MUX_out[0], MUX_out[1], MUX_out[2], MUX_out[3], MUX_out[4], MUX_out[5], MUX_out[6], MUX_out[7], MUX_out[8], MUX_out[9], MUX_out[10], MUX_out[11], MUX_out[12], MUX_out[13], MUX_out[14], MUX_out[15], MUX_out[16], MUX_out[17], MUX_out[18], MUX_out[19], MUX_out[20], MUX_out[21], MUX_out[22], MUX_out[23], MUX_out[24], MUX_out[25], MUX_out[26], MUX_out[27], MUX_out[28], MUX_out[29], MUX_out[30], MUX_out[31]);

// Connect carryout and overflow outputs
assign carryout = MUX_out[32];
assign overflow = MUX_out[33];
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
      `ADD:  begin assign out = in_ADD; end    
      `SUB:  begin assign out = in_SUB; end  
      `XOR:  begin assign out = in_XOR; end      
      `SLT:  begin assign out = in_SLT; end  
      `AND:  begin assign out = in_AND; end      
      `NAND: begin assign out = in_NAND; end  
      `NOR:  begin assign out = in_NOR; end      
      `OR:   begin assign out = in_OR; end  
    endcase
  end
endmodule

// test_ALUcontrolLUT no longer needed. MUX verified. Superseded by test_alu
// module test_ALUcontrolLUT;
// wire[33:0] out;
// reg[33:0] in_ADD;
// reg[33:0] in_SUB;
// reg[33:0] in_SLT;
// reg[33:0] in_XOR;
// reg[33:0] in_AND;
// reg[33:0] in_NAND;
// reg[33:0] in_OR;
// reg[33:0] in_NOR;
// reg[2:0]  ALUcommand;
// ALUcontrolLUT testALUlut(out, in_ADD, in_SUB, in_SLT, in_XOR, in_AND, in_NAND, in_NOR, in_OR, ALUcommand);

// initial begin
// // Can I select an input?
// $display("                                    Inputs                                    |                Output              |");
// $display("CMD | in_ADD                             | in_NOR                             | Mux Output                         |");
// ALUcommand=`ADD; in_ADD=34'b0111010000111010010011110100100101;  #1000
// $display("%b | %b | %b | %b |", ALUcommand, in_ADD, in_NOR, out);

// end
// endmodule

module test_alu;
wire[31:0]    res;
wire          cout;
wire          zero;
wire          ovf;
reg[31:0]     opA;
reg[31:0]     opB;
reg[2:0]      cmd;
ALU testALU(res, cout, zero, ovf, opA, opB, cmd);
initial begin
// Can I select an input?
$display("                                    Inputs                                    |                             Expected Outputs                  |                                Outputs                        |");
$display("command | operandA                         | operandB                         | result                           | carryout | overflow | zero | result                           | carryout | overflow | zero |");

// Add d1 + d1
cmd=`ADD; opA=32'b00000000000000000000000000000001; opB=32'b00000000000000000000000000000001; #5000
$display("%b     | %b | %b | 00000000000000000000000000000010 | 0        | 0        | 0    | %b | %b        | %b        | %b    |", cmd, opA, opB, res, cout, ovf, zero);

// Add d-1 and d1. Raise the zero flag
cmd=`ADD; opA=32'b11111111111111111111111111111111; opB=32'b00000000000000000000000000000001; #5000
$display("%b     | %b | %b | 00000000000000000000000000000000 | 0        | 0        | 1    | %b | %b        | %b        | %b    |", cmd, opA, opB, res, cout, ovf, zero);

// -5 + -21474836485 = 2147483643 OVERFLOW CARRYOUT
cmd=`ADD; opA=32'b11111111111111111111111111111011; opB=32'b10000000000000000000000000000000; #5000
$display("%b     | %b | %b | 01111111111111111111111111111011 | 1        | 1        | 0    | %b | %b        | %b        | %b    |", cmd, opA, opB, res, cout, ovf, zero);

// Check AND
cmd=`AND; opA=32'b00011111000001100011100000100001; opB=32'b00111111111111110000111000010001; #5000
$display("%b     | %b | %b | 00011111000001100000100000000001 | 0        | 0        | 0    | %b | %b        | %b        | %b    |", cmd, opA, opB, res, cout, ovf, zero);

// Check OR
cmd=`OR; opA=32'b00011111000001100011100000100001; opB=32'b00111111111111110000111000010001; #5000
$display("%b     | %b | %b | 00111111111111110011111000110001 | 0        | 0        | 0    | %b | %b        | %b        | %b    |", cmd, opA, opB, res, cout, ovf, zero);

// Check NOR
cmd=`NOR; opA=32'b00011111000001100011100000100001; opB=32'b00111111111111110000111000010001; #5000
$display("%b     | %b | %b | 11000000000000001100000111001110 | 0        | 0        | 0    | %b | %b        | %b        | %b    |", cmd, opA, opB, res, cout, ovf, zero);

// Check NAND
cmd=`NAND; opA=32'b00011111000001100011100000100001; opB=32'b00111111111111110000111000010001; #5000
$display("%b     | %b | %b | 11100000111110011111011111111110 | 0        | 0        | 0    | %b | %b        | %b        | %b    |", cmd, opA, opB, res, cout, ovf, zero);

// Check XOR
cmd=`XOR; opA=32'b00011111000001100011100000100001; opB=32'b00111111111111110000111000010001; #5000
$display("%b     | %b | %b | 00100000111110010011011000110000 | 0        | 0        | 0    | %b | %b        | %b        | %b    |", cmd, opA, opB, res, cout, ovf, zero);

// Check SUB
cmd=`SUB; opA=32'b00000000000000000000000000000100; opB=32'b00000000000000000000000000000011; #5000
$display("%b     | %b | %b | 00000000000000000000000000000001 | 0        | 0        | 0    | %b | %b        | %b        | %b    |", cmd, opA, opB, res, cout, ovf, zero);

// Check SLT true
cmd=`SLT; opA=32'b00000000000000000000000000000001; opB=32'b00000100000000000000000000000001; #5000
$display("%b     | %b | %b | 11111111111111111111111111111111 | 0        | 0        | 0    | %b | %b        | %b        | %b    |", cmd, opA, opB, res, cout, ovf, zero);

// Check SLT false
cmd=`SLT; opA=32'b00100000000000000000000000000001; opB=32'b00000000000000000000000000000001; #5000
$display("%b     | %b | %b | 00000000000000000000000000000000 | 0        | 0        | 1    | %b | %b        | %b        | %b    |", cmd, opA, opB, res, cout, ovf, zero);
end
endmodule