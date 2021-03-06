`define NAND2 nand #20
`define NOT not #10
`define NOR2 nor #20
`define XOR2 xor #60
// An XOR2 can be constructed from four NAND gates arranged in three tiers. https://en.wikipedia.org/wiki/XOR_gate#/media/File:XOR_from_NAND.svg
`define AND2 and #30
// An AND2 can be constructed from a NAND gate in series with a NOT gate
`define OR2 or #30
// An OR2 can be constructed from a NOR gate in series with a NOT gate

module FullAdder1bit
(
    output sum,         //sum of a and b
    output carryout,    // Carry out of summation of a and b
    input a,            // First operand (1-bit)
    input b,            // Second operand (1-bit)
    input carryin       // Carried In bit (1-bit)
);

wire xor1_O;
wire and1_O;
wire and2_O;

`XOR2 xor1(xor1_O, a, b);
`XOR2 xor2(sum, xor1_O, carryin);
`AND2 and1(and1_O, xor1_O, carryin);
`AND2 and2(and2_O, a, b);
`OR2 or1(carryout, and1_O, and2_O);
endmodule

module FullAdder32bit
(
 	output[31:0]sum,
	output carryout,
	output overflow,
	input[31:0] a,
	input[31:0] b
);
wire adder0_cout;
wire adder1_cout;
wire adder2_cout;
wire adder3_cout;
wire adder4_cout;
wire adder5_cout;
wire adder6_cout;
wire adder7_cout;
wire adder8_cout;
wire adder9_cout;
wire adder10_cout;
wire adder11_cout;
wire adder12_cout;
wire adder13_cout;
wire adder14_cout;
wire adder15_cout;
wire adder16_cout;
wire adder17_cout;
wire adder18_cout;
wire adder19_cout;
wire adder20_cout;
wire adder21_cout;
wire adder22_cout;
wire adder23_cout;
wire adder24_cout;
wire adder25_cout;
wire adder26_cout;
wire adder27_cout;
wire adder28_cout;
wire adder29_cout;
wire adder30_cout;
wire adder31_cout;
wire carryin_null = 0;
FullAdder1bit adder0(sum[0], adder0_cout, a[0], b[0], carryin_null);
FullAdder1bit adder1(sum[1], adder1_cout, a[1], b[1], adder0_cout);
FullAdder1bit adder2(sum[2], adder2_cout, a[2], b[2], adder1_cout);
FullAdder1bit adder3(sum[3], adder3_cout, a[3], b[3], adder2_cout);
FullAdder1bit adder4(sum[4], adder4_cout, a[4], b[4], adder3_cout);
FullAdder1bit adder5(sum[5], adder5_cout, a[5], b[5], adder4_cout);
FullAdder1bit adder6(sum[6], adder6_cout, a[6], b[6], adder5_cout);
FullAdder1bit adder7(sum[7], adder7_cout, a[7], b[7], adder6_cout);
FullAdder1bit adder8(sum[8], adder8_cout, a[8], b[8], adder7_cout);
FullAdder1bit adder9(sum[9], adder9_cout, a[9], b[9], adder8_cout);
FullAdder1bit adder10(sum[10], adder10_cout, a[10], b[10], adder9_cout);
FullAdder1bit adder11(sum[11], adder11_cout, a[11], b[11], adder10_cout);
FullAdder1bit adder12(sum[12], adder12_cout, a[12], b[12], adder11_cout);
FullAdder1bit adder13(sum[13], adder13_cout, a[13], b[13], adder12_cout);
FullAdder1bit adder14(sum[14], adder14_cout, a[14], b[14], adder13_cout);
FullAdder1bit adder15(sum[15], adder15_cout, a[15], b[15], adder14_cout);
FullAdder1bit adder16(sum[16], adder16_cout, a[16], b[16], adder15_cout);
FullAdder1bit adder17(sum[17], adder17_cout, a[17], b[17], adder16_cout);
FullAdder1bit adder18(sum[18], adder18_cout, a[18], b[18], adder17_cout);
FullAdder1bit adder19(sum[19], adder19_cout, a[19], b[19], adder18_cout);
FullAdder1bit adder20(sum[20], adder20_cout, a[20], b[20], adder19_cout);
FullAdder1bit adder21(sum[21], adder21_cout, a[21], b[21], adder20_cout);
FullAdder1bit adder22(sum[22], adder22_cout, a[22], b[22], adder21_cout);
FullAdder1bit adder23(sum[23], adder23_cout, a[23], b[23], adder22_cout);
FullAdder1bit adder24(sum[24], adder24_cout, a[24], b[24], adder23_cout);
FullAdder1bit adder25(sum[25], adder25_cout, a[25], b[25], adder24_cout);
FullAdder1bit adder26(sum[26], adder26_cout, a[26], b[26], adder25_cout);
FullAdder1bit adder27(sum[27], adder27_cout, a[27], b[27], adder26_cout);
FullAdder1bit adder28(sum[28], adder28_cout, a[28], b[28], adder27_cout);
FullAdder1bit adder29(sum[29], adder29_cout, a[29], b[29], adder28_cout);
FullAdder1bit adder30(sum[30], adder30_cout, a[30], b[30], adder29_cout);
FullAdder1bit adder31(sum[31], carryout, a[31], b[31], adder30_cout);
`XOR2 overflowxor (overflow, adder30_cout, carryout);
endmodule

module test_adder32;
// 32-bit adder has inputs a,b ; outputs sum, ovf, cout
reg [31:0] a;
reg [31:0] b;
wire [31:0] sum;
wire cout;
wire ovf;
// Instantiate 32-bit adder here
FullAdder32bit test_adder(sum, cout, ovf, a, b);

initial begin
$display("                               Inputs                               |                        Expected Outputs                                 |                                 Outputs                               |");
$display("a                                | b                                | a + b                            | overflow         | carryout          | a + b                            | overflow        | carryout         |");

// Test basic 1-bit addition
// 0 + 0 = 0
a=32'b00000000000000000000000000000000;b=32'b00000000000000000000000000000000; #1000
$display("%b | %b | 00000000000000000000000000000000 | 0                | 0                 | %b | %b               | %b                |", a, b, sum, ovf, cout);

// 0 + 1 = 1
a=32'b00000000000000000000000000000000;b=32'b00000000000000000000000000000001; #1000
$display("%b | %b | 00000000000000000000000000000001 | 0                | 0                 | %b | %b               | %b                |", a, b, sum, ovf, cout);

// 1 + 0 = 1
a=32'b00000000000000000000000000000001;b=32'b00000000000000000000000000000000; #1000
$display("%b | %b | 00000000000000000000000000000001 | 0                | 0                 | %b | %b               | %b                |", a, b, sum, ovf, cout);

// 1 + 1 = 2
a=32'b00000000000000000000000000000001;b=32'b00000000000000000000000000000001; #1000
$display("%b | %b | 00000000000000000000000000000010 | 0                | 0                 | %b | %b               | %b                |", a, b, sum, ovf, cout);

// Test carryout output
// 1 + -1 = 0 w/C.O. 1
a=32'b00000000000000000000000000000001;b=32'b11111111111111111111111111111111; #1000
$display("%b | %b | 00000000000000000000000000000000 | 0                | 1                 | %b | %b               | %b                |", a, b, sum, ovf, cout);

// -1 + 1 = 0 w/C.O. 1
a=32'b11111111111111111111111111111111;b=32'b00000000000000000000000000000001; #1000
$display("%b | %b | 00000000000000000000000000000000 | 0                | 1                 | %b | %b               | %b                |", a, b, sum, ovf, cout);

// Test carry propagation

// -262145 + 1 = -262144
a=32'b11111111111110111111111111111111;b=32'b00000000000000000000000000000001; #1000
$display("%b | %b | 11111111111111000000000000000000 | 0                | 0                 | %b | %b               | %b                |", a, b, sum, ovf, cout);

// 1 + -262145 = -262144
a=32'b00000000000000000000000000000001;b=32'b11111111111110111111111111111111; #1000
$display("%b | %b | 11111111111111000000000000000000 | 0                | 0                 | %b | %b               | %b                |", a, b, sum, ovf, cout);

// 67108864 + -1 = 67108863
a=32'b00000100000000000000000000000000;b=32'b11111111111111111111111111111111; #1000
$display("%b | %b | 00000011111111111111111111111111 | 0                | 1                 | %b | %b               | %b                |", a, b, sum, ovf, cout);

// Test overflow
// Negative overflow
//-2147483648 + -5 = 2147483643 OVERFLOW CARRYOUT
a=32'b10000000000000000000000000000000;b=32'b11111111111111111111111111111011; #1000
$display("%b | %b | 01111111111111111111111111111011 | 1                | 1                 | %b | %b               | %b                |", a, b, sum, ovf, cout);

//-5 + -21474836485 = 2147483643 OVERFLOW CARRYOUT
a=32'b11111111111111111111111111111011;b=32'b10000000000000000000000000000000; #1000
$display("%b | %b | 01111111111111111111111111111011 | 1                | 1                 | %b | %b               | %b                |", a, b, sum, ovf, cout);

// Positive overflow
// 2147483647 + 2 = -2147483647 OVERFLOW
a=32'b01111111111111111111111111111111;b=32'b00000000000000000000000000000010; #1000
$display("%b | %b | 10000000000000000000000000000001 | 1                | 0                 | %b | %b               | %b                |", a, b, sum, ovf, cout);

// 2 + 2147483647 = -2147483647 OVERFLOW
a=32'b00000000000000000000000000000010;b=32'b01111111111111111111111111111111; #1000
$display("%b | %b | 10000000000000000000000000000001 | 1                | 0                 | %b | %b               | %b                |", a, b, sum, ovf, cout);

end
endmodule

module test_slt32;
// 32-bit SLT has inputs a,b ; output r
// Meg--any input from subtractor? Wire it here. 
reg [31:0] a;
reg [31:0] b;
wire [31:0] r;

// Instantiate 32-bit subtractor here
SLT32 test_SLT(sum, cout, ovf, a, b);

initial begin
$display("                               Inputs                               | Expected Output | Output |");
$display("a                                | b                                | a < b           | a < b  |");

// Comparing positive numbers
// 2 < 1 => 0
a=32'b00000000000000000000000000000010;b=32'b00000000000000000000000000000001; #1000
$display("%b | %b | %b               | %b      |", a, b, 32'b0, r);

// 1 < 2 => 1
a=32'b00000000000000000000000000000001;b=32'b00000000000000000000000000000010; #1000
$display("%b | %b | %b               | %b      |", a, b, 32'b1, r);

//2147483647 < 35 => 0
a=32'b01111111111111111111111111111111;b=32'b00000000000000000000000000100011; #1000
$display("%b | %b | %b               | %b      |", a, b, 32'b0, r);

// 35 < 2147483647 => 1
a=32'b00000000000000000000000000100011;b=32'b01111111111111111111111111111111; #1000
$display("%b | %b | %b               | %b      |", a, b, 32'b1, r);

// Comparing negative numbers
// -1 < -2 => 0
a=32'b11111111111111111111111111111111;b=32'b11111111111111111111111111111110; #1000
$display("%b | %b | %b               | %b      |", a, b, 32'b0, r);

// -2 < -1 => 1
a=32'b11111111111111111111111111111110;b=32'b11111111111111111111111111111111; #1000
$display("%b | %b | %b               | %b      |", a, b, 32'b1, r);

// -2147483648 < -513 => 1
a=32'b10000000000000000000000000000000;b=32'b11111111111111111111110111111111; #1000
$display("%b | %b | %b               | %b      |", a, b, 32'b1, r);

// -513 < -2147483648 => 0
a=32'b11111111111111111111110111111111;b=32'b10000000000000000000000000000000; #1000
$display("%b | %b | %b               | %b      |", a, b, 32'b0, r);

// Comparing positive and negative numbers
// 1 < -1 => 0
a=32'b00000000000000000000000000000001;b=32'b11111111111111111111111111111111; #1000
$display("%b | %b | %b               | %b      |", a, b, 32'b0, r);

// -1 < 1 => 1
a=32'b11111111111111111111111111111111;b=32'b00000000000000000000000000000001; #1000
$display("%b | %b | %b               | %b      |", a, b, 32'b1, r);

// 32 < -8192 => 0
a=32'b00000000000000000000000000100000;b=32'b11111111111111111110000000000000; #1000
$display("%b | %b | %b               | %b      |", a, b, 32'b0, r);

// -8192 < 32 => 1
a=32'b11111111111111111110000000000000;b=32'b00000000000000000000000000100000; #1000
$display("%b | %b | %b               | %b      |", a, b, 32'b1, r);

// Comparing (with) zeros
// 0 < 0 => 0 
a=32'b00000000000000000000000000000000;b=32'b00000000000000000000000000000000; #1000
$display("%b | %b | %b               | %b      |", a, b, 32'b0, r);

// 0 < 1 => 1
a=32'b00000000000000000000000000000000;b=32'b00000000000000000000000000000001; #1000
$display("%b | %b | %b               | %b      |", a, b, 32'b1, r);

// 1 < 0 => 0
a=32'b00000000000000000000000000000001;b=32'b00000000000000000000000000000000; #1000
$display("%b | %b | %b               | %b      |", a, b, 32'b0, r);

// 0 < -1 => 0
a=32'b00000000000000000000000000000000;b=32'b00000000000000000000000000000001; #1000
$display("%b | %b | %b               | %b      |", a, b, 32'b0, r);

// -1 < 0 => 1
a=32'b00000000000000000000000000000000;b=32'b00000000000000000000000000000001; #1000
$display("%b | %b | %b               | %b      |", a, b, 32'b1, r);

// Comparing with SUB overflow 
// -2147483648 < 5 => 1 [-2147483648 - 5 = 2147483643 OVERFLOW]
a=32'b10000000000000000000000000000000;b=32'b00000000000000000000000000000101; #1000
$display("%b | %b | %b               | %b      |", a, b, 32'b1, r);

// -5 < 21474836485 => 1 [-5 - 21474836485 = 2147483646 OVERFLOW]
a=32'b11111111111111111111111111111011;b=32'b01111111111111111111111111111101; #1000
$display("%b | %b | %b               | %b      |", a, b, 32'b1, r);

// Comparing with ADD overflow
// -21474836485 < -5 => 1 [-2147483648 + -5 = 2147483643 OVERFLOW]
a=32'b10000000000000000000000000000000;b=32'b11111111111111111111111111111011; #1000
$display("%b | %b | %b               | %b      |", a, b, 32'b1, r);

// -5 < -21474836485 => 0 [-5 + -21474836485 = 2147483643 OVERFLOW]
a=32'b11111111111111111111111111111011;b=32'b10000000000000000000000000000000; #1000
$display("%b | %b | %b               | %b      |", a, b, 32'b0, r);

// Positive overflow
// 2147483647 < 2 => 0[2147483647 + 2 = -2147483647 OVERFLOW]
a=32'b01111111111111111111111111111111;b=32'b00000000000000000000000000000010; #1000
$display("%b | %b | %b               | %b      |", a, b, 32'b0, r);

// 2 < 2147483647 => 1 [2 + 2147483647 = -2147483647 OVERFLOW]
a=32'b00000000000000000000000000000010;b=32'b01111111111111111111111111111111; #1000
$display("%b | %b | %b               | %b      |", a, b, 32'b1, r);

end
endmodule