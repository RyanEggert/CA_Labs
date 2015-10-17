
`define AND and #20
`define OR or #20
`define NOT not #10
`define XOR xor #20
`define XNOR xnor #20

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

`XOR xor1(xor1_O, a, b);
`XOR xor2(sum, xor1_O, carryin);
`AND and1(and1_O, xor1_O, carryin);
`AND and2(and2_O, a, b);
`OR or1(carryout, and1_O, and2_O);
endmodule

module FullSubtractor32bit
(

	output[31:0]sum,
	output carryout,
	output overflow,
	input[31:0] a,
	input[31:0] b
);
wire subtract0_cout;
wire subtract1_cout;
wire subtract2_cout;
wire subtract3_cout;
wire subtract4_cout;
wire subtract5_cout;
wire subtract6_cout;
wire subtract7_cout;
wire subtract8_cout;
wire subtract9_cout;
wire subtract10_cout;
wire subtract11_cout;
wire subtract12_cout;
wire subtract13_cout;
wire subtract14_cout;
wire subtract15_cout;
wire subtract16_cout;
wire subtract17_cout;
wire subtract18_cout;
wire subtract19_cout;
wire subtract20_cout;
wire subtract21_cout;
wire subtract22_cout;
wire subtract23_cout;
wire subtract24_cout;
wire subtract25_cout;
wire subtract26_cout;
wire subtract27_cout;
wire subtract28_cout;
wire subtract29_cout;
wire subtract30_cout;
wire subtract31_cout;
wire carryin_null = 1;
wire nb_0;
wire nb_1;
wire nb_2;
wire nb_3;
wire nb_4;
wire nb_5;
wire nb_6;
wire nb_7;
wire nb_8;
wire nb_9;
wire nb_10;
wire nb_11;
wire nb_12;
wire nb_13;
wire nb_14;
wire nb_15;
wire nb_16;
wire nb_17;
wire nb_18;
wire nb_19;
wire nb_20;
wire nb_21;
wire nb_22;
wire nb_23;
wire nb_24;
wire nb_25;
wire nb_26;
wire nb_27;
wire nb_28;
wire nb_29;
wire nb_30;
wire nb_31;
`NOT nb0(nb_0, b[0]);
`NOT nb1(nb_1, b[1]);
`NOT nb2(nb_2, b[2]);
`NOT nb3(nb_3, b[3]);
`NOT nb4(nb_4, b[4]);
`NOT nb5(nb_5, b[5]);
`NOT nb6(nb_6, b[6]);
`NOT nb7(nb_7, b[7]);
`NOT nb8(nb_8, b[8]);
`NOT nb9(nb_9, b[9]);
`NOT nb10(nb_10, b[10]);
`NOT nb11(nb_11, b[11]);
`NOT nb12(nb_12, b[12]);
`NOT nb13(nb_13, b[13]);
`NOT nb14(nb_14, b[14]);
`NOT nb15(nb_15, b[15]);
`NOT nb16(nb_16, b[16]);
`NOT nb17(nb_17, b[17]);
`NOT nb18(nb_18, b[18]);
`NOT nb19(nb_19, b[19]);
`NOT nb20(nb_20, b[20]);
`NOT nb21(nb_21, b[21]);
`NOT nb22(nb_22, b[22]);
`NOT nb23(nb_23, b[23]);
`NOT nb24(nb_24, b[24]);
`NOT nb25(nb_25, b[25]);
`NOT nb26(nb_26, b[26]);
`NOT nb27(nb_27, b[27]);
`NOT nb28(nb_28, b[28]);
`NOT nb29(nb_29, b[29]);
`NOT nb30(nb_30, b[30]);
`NOT nb31(nb_31, b[31]);

FullAdder1bit subtract0(sum[0], subtract0_cout, a[0], nb_0, carryin_null);
FullAdder1bit subtract1(sum[1], subtract1_cout, a[1], nb_1, subtract0_cout);
FullAdder1bit subtract2(sum[2], subtract2_cout, a[2], nb_2, subtract1_cout);
FullAdder1bit subtract3(sum[3], subtract3_cout, a[3], nb_3, subtract2_cout);
FullAdder1bit subtract4(sum[4], subtract4_cout, a[4], nb_4, subtract3_cout);
FullAdder1bit subtract5(sum[5], subtract5_cout, a[5], nb_5, subtract4_cout);
FullAdder1bit subtract6(sum[6], subtract6_cout, a[6], nb_6, subtract5_cout);
FullAdder1bit subtract7(sum[7], subtract7_cout, a[7], nb_7, subtract6_cout);
FullAdder1bit subtract8(sum[8], subtract8_cout, a[8], nb_8, subtract7_cout);
FullAdder1bit subtract9(sum[9], subtract9_cout, a[9], nb_9, subtract8_cout);
FullAdder1bit subtract10(sum[10], subtract10_cout, a[10], nb_10, subtract9_cout);
FullAdder1bit subtract11(sum[11], subtract11_cout, a[11], nb_11, subtract10_cout);
FullAdder1bit subtract12(sum[12], subtract12_cout, a[12], nb_12, subtract11_cout);
FullAdder1bit subtract13(sum[13], subtract13_cout, a[13], nb_13, subtract12_cout);
FullAdder1bit subtract14(sum[14], subtract14_cout, a[14], nb_14, subtract13_cout);
FullAdder1bit subtract15(sum[15], subtract15_cout, a[15], nb_15, subtract14_cout);
FullAdder1bit subtract16(sum[16], subtract16_cout, a[16], nb_16, subtract15_cout);
FullAdder1bit subtract17(sum[17], subtract17_cout, a[17], nb_17, subtract16_cout);
FullAdder1bit subtract18(sum[18], subtract18_cout, a[18], nb_18, subtract17_cout);
FullAdder1bit subtract19(sum[19], subtract19_cout, a[19], nb_19, subtract18_cout);
FullAdder1bit subtract20(sum[20], subtract20_cout, a[20], nb_20, subtract19_cout);
FullAdder1bit subtract21(sum[21], subtract21_cout, a[21], nb_21, subtract20_cout);
FullAdder1bit subtract22(sum[22], subtract22_cout, a[22], nb_22, subtract21_cout);
FullAdder1bit subtract23(sum[23], subtract23_cout, a[23], nb_23, subtract22_cout);
FullAdder1bit subtract24(sum[24], subtract24_cout, a[24], nb_24, subtract23_cout);
FullAdder1bit subtract25(sum[25], subtract25_cout, a[25], nb_25, subtract24_cout);
FullAdder1bit subtract26(sum[26], subtract26_cout, a[26], nb_26, subtract25_cout);
FullAdder1bit subtract27(sum[27], subtract27_cout, a[27], nb_27, subtract26_cout);
FullAdder1bit subtract28(sum[28], subtract28_cout, a[28], nb_28, subtract27_cout);
FullAdder1bit subtract29(sum[29], subtract29_cout, a[29], nb_29, subtract28_cout);
FullAdder1bit subtract30(sum[30], subtract30_cout, a[30], nb_30, subtract29_cout);
FullAdder1bit subtract31(sum[31], carryout, a[31], nb_31, subtract30_cout);
$display("%b", carryout);
xor overflowxor (overflow, subtract30_cout, carryout);
endmodule

module test_subtractor32;
// 32-bit subtractor has inputs a,b ; outputs sum, ovf, cout
reg [31:0] a;
reg [31:0] b;
wire [31:0] sum;
wire cout;
wire ovf;
// Instantiate 32-bit subtractor here
FullSubtractor32bit test_subtractor32(sum, cout, ovf, a, b);

initial begin
$display("                               Inputs                               |                        Expected Outputs                                 |                                 Outputs                               |");
$display("a                                | b                                | a + b                            | overflow         | carryout          | a + b                            | overflow        | carryout         |");

// Test basic 1-bit subtraction. 
// Zero handling (validating two's complement of zero)
// 0 - 0 = 0
a=32'b00000000000000000000000000000000;b=32'b00000000000000000000000000000000; #2000
$display("%b | %b | 00000000000000000000000000000000 | 0                | 0                 | %b | %b               | %b                |", a, b, sum, ovf, cout);

// 0 - 1 = 1
a=32'b00000000000000000000000000000000;b=32'b00000000000000000000000000000001; #2000
$display("%b | %b | 11111111111111111111111111111111 | 0                | 0                 | %b | %b               | %b                |", a, b, sum, ovf, cout);

// 1 - 0 = 1
a=32'b00000000000000000000000000000001;b=32'b00000000000000000000000000000000; #2000
$display("%b | %b | 00000000000000000000000000000001 | 0                | 0                 | %b | %b               | %b                |", a, b, sum, ovf, cout);

// 1 - -1 = 2
a=32'b00000000000000000000000000000001;b=32'b11111111111111111111111111111111; #2000
$display("%b | %b | 00000000000000000000000000000010 | 0                | 0                 | %b | %b               | %b                |", a, b, sum, ovf, cout);

// Test carryout output
// 1 - 1 = 0 w/C.O. 1
a=32'b00000000000000000000000000000001;b=32'b00000000000000000000000000000001; #2000
$display("%b | %b | 00000000000000000000000000000000 | 0                | 1                 | %b | %b               | %b                |", a, b, sum, ovf, cout);

// -1 - -1 = 0 w/C.O. 1
a=32'b11111111111111111111111111111111;b=32'b11111111111111111111111111111111; #2000
$display("%b | %b | 00000000000000000000000000000000 | 0                | 1                 | %b | %b               | %b                |", a, b, sum, ovf, cout);

// Test carry propagation
// -262145 - -1 = -262144
a=32'b11111111111110111111111111111111;b=32'b11111111111111111111111111111111; #2000
$display("%b | %b | 11111111111111000000000000000000 | 0                | 0                 | %b | %b               | %b                |", a, b, sum, ovf, cout);

// 1 - 262145 = -262144
a=32'b00000000000000000000000000000001;b=32'b00000000000001000000000000000001; #2000
$display("%b | %b | 11111111111111000000000000000000 | 0                | 0                 | %b | %b               | %b                |", a, b, sum, ovf, cout);

// 67108864 - 1 = 67108863
a=32'b00000100000000000000000000000000;b=32'b00000000000000000000000000000011; #2000
$display("%b | %b | 00000011111111111111111111111111 | 0                | 1                 | %b | %b               | %b                |", a, b, sum, ovf, cout);

// Test overflow
// Negative overflow
//-2147483648 - 5 = 2147483643 OVERFLOW
a=32'b10000000000000000000000000000000;b=32'b00000000000000000000000000000101; #2000
$display("%b | %b | 01111111111111111111111111111011 | 1                | 1                 | %b | %b               | %b                |", a, b, sum, ovf, cout);

//-5 - 21474836485 = 2147483646 OVERFLOW
a=32'b11111111111111111111111111111011;b=32'b01111111111111111111111111111101; #2000
$display("%b | %b | 01111111111111111111111111111110 | 1                | 1                 | %b | %b               | %b                |", a, b, sum, ovf, cout);

// Positive overflow
// 2147483647 - -2 = -2147483647 OVERFLOW
a=32'b01111111111111111111111111111111;b=32'b11111111111111111111111111111110; #2000
$display("%b | %b | 10000000000000000000000000000001 | 1                | 0                 | %b | %b               | %b                |", a, b, sum, ovf, cout);

// 2 - -21474836485 = -2147483643 OVERFLOW
a=32'b00000000000000000000000000000010;b=32'b01111111111111111111111111111101; #2000
$display("%b | %b | 10000000000000000000000000000001 | 1                | 0                 | %b | %b               | %b                |", a, b, sum, ovf, cout);

end
endmodule