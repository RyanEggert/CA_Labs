// This our logical subunit file. It includes the code and test functions for all the logical operations. 
// All of th repetitive code in this file was written using python scripts. 
// All the logical operations are completed with the basic gates NAND, NOT, and NOR so we defined them below and added an appropriate delay.

`define NAND nand #20
`define NOT not #10
`define NOR nor #20


//Module for the OR Operation. Calculated Or using Nor and Not. 

module Or32Bit
(
 	output[31:0]out,
	input[31:0] a,
	input[31:0] b
);
//Or is simply a not nor 
wire nor_0;
wire nor_1;
wire nor_2;
wire nor_3;
wire nor_4;
wire nor_5;
wire nor_6;
wire nor_7;
wire nor_8;
wire nor_9;
wire nor_10;
wire nor_11;
wire nor_12;
wire nor_13;
wire nor_14;
wire nor_15;
wire nor_16;
wire nor_17;
wire nor_18;
wire nor_19;
wire nor_20;
wire nor_21;
wire nor_22;
wire nor_23;
wire nor_24;
wire nor_25;
wire nor_26;
wire nor_27;
wire nor_28;
wire nor_29;
wire nor_30;
wire nor_31;
`NOR nor0(nor_0, a[0], b[0]);
`NOT or0(out[0], nor_0);
`NOR nor1(nor_1, a[1], b[1]);
`NOT or1(out[1], nor_1);
`NOR nor2(nor_2, a[2], b[2]);
`NOT or2(out[2], nor_2);
`NOR nor3(nor_3, a[3], b[3]);
`NOT or3(out[3], nor_3);
`NOR nor4(nor_4, a[4], b[4]);
`NOT or4(out[4], nor_4);
`NOR nor5(nor_5, a[5], b[5]);
`NOT or5(out[5], nor_5);
`NOR nor6(nor_6, a[6], b[6]);
`NOT or6(out[6], nor_6);
`NOR nor7(nor_7, a[7], b[7]);
`NOT or7(out[7], nor_7);
`NOR nor8(nor_8, a[8], b[8]);
`NOT or8(out[8], nor_8);
`NOR nor9(nor_9, a[9], b[9]);
`NOT or9(out[9], nor_9);
`NOR nor10(nor_10, a[10], b[10]);
`NOT or10(out[10], nor_10);
`NOR nor11(nor_11, a[11], b[11]);
`NOT or11(out[11], nor_11);
`NOR nor12(nor_12, a[12], b[12]);
`NOT or12(out[12], nor_12);
`NOR nor13(nor_13, a[13], b[13]);
`NOT or13(out[13], nor_13);
`NOR nor14(nor_14, a[14], b[14]);
`NOT or14(out[14], nor_14);
`NOR nor15(nor_15, a[15], b[15]);
`NOT or15(out[15], nor_15);
`NOR nor16(nor_16, a[16], b[16]);
`NOT or16(out[16], nor_16);
`NOR nor17(nor_17, a[17], b[17]);
`NOT or17(out[17], nor_17);
`NOR nor18(nor_18, a[18], b[18]);
`NOT or18(out[18], nor_18);
`NOR nor19(nor_19, a[19], b[19]);
`NOT or19(out[19], nor_19);
`NOR nor20(nor_20, a[20], b[20]);
`NOT or20(out[20], nor_20);
`NOR nor21(nor_21, a[21], b[21]);
`NOT or21(out[21], nor_21);
`NOR nor22(nor_22, a[22], b[22]);
`NOT or22(out[22], nor_22);
`NOR nor23(nor_23, a[23], b[23]);
`NOT or23(out[23], nor_23);
`NOR nor24(nor_24, a[24], b[24]);
`NOT or24(out[24], nor_24);
`NOR nor25(nor_25, a[25], b[25]);
`NOT or25(out[25], nor_25);
`NOR nor26(nor_26, a[26], b[26]);
`NOT or26(out[26], nor_26);
`NOR nor27(nor_27, a[27], b[27]);
`NOT or27(out[27], nor_27);
`NOR nor28(nor_28, a[28], b[28]);
`NOT or28(out[28], nor_28);
`NOR nor29(nor_29, a[29], b[29]);
`NOT or29(out[29], nor_29);
`NOR nor30(nor_30, a[30], b[30]);
`NOT or30(out[30], nor_30);
`NOR nor31(nor_31, a[31], b[31]);
`NOT or31(out[31], nor_31);
endmodule


// test module for OR. 

module test_OR;

reg [31:0] a;
reg [31:0] b;
wire [31:0] out;

Or32Bit test_OR(out, a, b);


initial begin
$display("                               Inputs                               |              Outputs             |         Expected Outputs         |");
$display("a                                | b                                | a OR b                           |");
// Test all one-bit combinations
a=32'b00000000000000000000000000000000; b=32'b00000000000000000000000000000000; #3000
$display("%b | %b | %b | 00000000000000000000000000000000 |", a, b, out);

a=32'b00000000000000000000000000000000; b=32'b00000000000000000000000000000001; #3000
$display("%b | %b | %b | 00000000000000000000000000000001 |", a, b, out);

a=32'b00000000000000000000000000000001; b=32'b00000000000000000000000000000000; #3000 
$display("%b | %b | %b | 00000000000000000000000000000001 |", a, b, out);

a=32'b00000000000000000000000000000001; b=32'b00000000000000000000000000000001; #3000
$display("%b | %b | %b | 00000000000000000000000000000001 |", a, b, out);

//Test ones handling
a=32'b11111111111111111111111111111111; b=32'b11111111111111111111111111111111; #3000
$display("%b | %b | %b | 11111111111111111111111111111111 |", a, b, out);

a=32'b00000000000000000000000000000000; b=32'b11111111111111111111111111111111; #3000
$display("%b | %b | %b | 11111111111111111111111111111111 |", a, b, out);

// "Interlaced" inputs
a=32'b10101010101010101010101010101010; b=32'b01010101010101010101010101010101; #3000
$display("%b | %b | %b | 11111111111111111111111111111111 |", a, b, out);

a=32'b00000000000000000000000000000011; b=32'b00000000000000000000000000000100; #3000
$display("%b | %b | %b | 00000000000000000000000000000111 |", a, b, out);

a=32'b00110100111110110101111000111000; b=32'b01011011000111110001100010010011; #3000
$display("%b | %b | %b | 01111111111111110101111010111011 |", a, b, out);

a=32'b00000000000000000000000000000011; b=32'b00000000000011000000000000000011; #3000
$display("%b | %b | %b | 00000000000011000000000000000011 |", a, b, out);

end
endmodule

//Module for the NOR Operation. Calculated Nor using just the Nor gate.

module Nor32Bit
(
 	output[31:0]out,
	input[31:0] a,
	input[31:0] b
);
`NOR nor0(out[0], a[0], b[0]);
`NOR nor1(out[1], a[1], b[1]);
`NOR nor2(out[2], a[2], b[2]);
`NOR nor3(out[3], a[3], b[3]);
`NOR nor4(out[4], a[4], b[4]);
`NOR nor5(out[5], a[5], b[5]);
`NOR nor6(out[6], a[6], b[6]);
`NOR nor7(out[7], a[7], b[7]);
`NOR nor8(out[8], a[8], b[8]);
`NOR nor9(out[9], a[9], b[9]);
`NOR nor10(out[10], a[10], b[10]);
`NOR nor11(out[11], a[11], b[11]);
`NOR nor12(out[12], a[12], b[12]);
`NOR nor13(out[13], a[13], b[13]);
`NOR nor14(out[14], a[14], b[14]);
`NOR nor15(out[15], a[15], b[15]);
`NOR nor16(out[16], a[16], b[16]);
`NOR nor17(out[17], a[17], b[17]);
`NOR nor18(out[18], a[18], b[18]);
`NOR nor19(out[19], a[19], b[19]);
`NOR nor20(out[20], a[20], b[20]);
`NOR nor21(out[21], a[21], b[21]);
`NOR nor22(out[22], a[22], b[22]);
`NOR nor23(out[23], a[23], b[23]);
`NOR nor24(out[24], a[24], b[24]);
`NOR nor25(out[25], a[25], b[25]);
`NOR nor26(out[26], a[26], b[26]);
`NOR nor27(out[27], a[27], b[27]);
`NOR nor28(out[28], a[28], b[28]);
`NOR nor29(out[29], a[29], b[29]);
`NOR nor30(out[30], a[30], b[30]);
`NOR nor31(out[31], a[31], b[31]);
endmodule


// test module for NOR. 

module test_NOR;
reg [31:0] a;
reg [31:0] b;
wire [31:0] out;

Nor32Bit test_NOR(out, a, b);


initial begin
$display("                               Inputs                               |              Outputs             |         Expected Outputs         |");
$display("a                                | b                                | a NOR b                          |");
// Test all one-bit combinations
a=32'b00000000000000000000000000000000; b=32'b00000000000000000000000000000000; #3000
$display("%b | %b | %b | 11111111111111111111111111111111 |", a, b, out);

a=32'b00000000000000000000000000000000; b=32'b00000000000000000000000000000001; #3000
$display("%b | %b | %b | 11111111111111111111111111111110 |", a, b, out);

a=32'b00000000000000000000000000000001; b=32'b00000000000000000000000000000000; #3000
$display("%b | %b | %b | 11111111111111111111111111111110 |", a, b, out);

a=32'b00000000000000000000000000000001; b=32'b00000000000000000000000000000001; #3000
$display("%b | %b | %b | 11111111111111111111111111111110 |", a, b, out);

//Test ones handling
a=32'b11111111111111111111111111111111; b=32'b11111111111111111111111111111111; #3000
$display("%b | %b | %b | 00000000000000000000000000000000 |", a, b, out);

a=32'b00000000000000000000000000000000; b=32'b11111111111111111111111111111111; #3000
$display("%b | %b | %b | 00000000000000000000000000000000 |", a, b, out);

// "Interlaced" inputs
a=32'b10101010101010101010101010101010; b=32'b01010101010101010101010101010101; #3000
$display("%b | %b | %b | 00000000000000000000000000000000 |", a, b, out);

a=32'b00000000000000000000000000000011; b=32'b00000000000000000000000000000100; #3000
$display("%b | %b | %b | 11111111111111111111111111111000 |", a, b, out);

a=32'b00110100111110110101111000111000; b=32'b01011011000111110001100010010011; #3000
$display("%b | %b | %b | 10000000000000001010000101000100 |", a, b, out);

a=32'b00000000000000000000000000000011; b=32'b00000000000011000000000000000011; #3000
$display("%b | %b | %b | 11111111111100111111111111111100 |", a, b, out);

end
endmodule


//Module for the XOR Operation. Calculated Xor using 4 NAND gates for each bit more info below. 


module Xor32Bit
(
 	output[31:0]out,
	input[31:0] a,
	input[31:0] b
);
//To get Xor, used Nand(Nand(a, Nand(a,b)), Nand(Nand(a,b), b)), found here: https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/XOR_from_NAND.svg/300px-XOR_from_NAND.svg.png
wire nandab_0;
wire nandaab_0;
wire nandabb_0;
wire nandaabb_0;
wire nandab_1;
wire nandaab_1;
wire nandabb_1;
wire nandaabb_1;
wire nandab_2;
wire nandaab_2;
wire nandabb_2;
wire nandaabb_2;
wire nandab_3;
wire nandaab_3;
wire nandabb_3;
wire nandaabb_3;
wire nandab_4;
wire nandaab_4;
wire nandabb_4;
wire nandaabb_4;
wire nandab_5;
wire nandaab_5;
wire nandabb_5;
wire nandaabb_5;
wire nandab_6;
wire nandaab_6;
wire nandabb_6;
wire nandaabb_6;
wire nandab_7;
wire nandaab_7;
wire nandabb_7;
wire nandaabb_7;
wire nandab_8;
wire nandaab_8;
wire nandabb_8;
wire nandaabb_8;
wire nandab_9;
wire nandaab_9;
wire nandabb_9;
wire nandaabb_9;
wire nandab_10;
wire nandaab_10;
wire nandabb_10;
wire nandaabb_10;
wire nandab_11;
wire nandaab_11;
wire nandabb_11;
wire nandaabb_11;
wire nandab_12;
wire nandaab_12;
wire nandabb_12;
wire nandaabb_12;
wire nandab_13;
wire nandaab_13;
wire nandabb_13;
wire nandaabb_13;
wire nandab_14;
wire nandaab_14;
wire nandabb_14;
wire nandaabb_14;
wire nandab_15;
wire nandaab_15;
wire nandabb_15;
wire nandaabb_15;
wire nandab_16;
wire nandaab_16;
wire nandabb_16;
wire nandaabb_16;
wire nandab_17;
wire nandaab_17;
wire nandabb_17;
wire nandaabb_17;
wire nandab_18;
wire nandaab_18;
wire nandabb_18;
wire nandaabb_18;
wire nandab_19;
wire nandaab_19;
wire nandabb_19;
wire nandaabb_19;
wire nandab_20;
wire nandaab_20;
wire nandabb_20;
wire nandaabb_20;
wire nandab_21;
wire nandaab_21;
wire nandabb_21;
wire nandaabb_21;
wire nandab_22;
wire nandaab_22;
wire nandabb_22;
wire nandaabb_22;
wire nandab_23;
wire nandaab_23;
wire nandabb_23;
wire nandaabb_23;
wire nandab_24;
wire nandaab_24;
wire nandabb_24;
wire nandaabb_24;
wire nandab_25;
wire nandaab_25;
wire nandabb_25;
wire nandaabb_25;
wire nandab_26;
wire nandaab_26;
wire nandabb_26;
wire nandaabb_26;
wire nandab_27;
wire nandaab_27;
wire nandabb_27;
wire nandaabb_27;
wire nandab_28;
wire nandaab_28;
wire nandabb_28;
wire nandaabb_28;
wire nandab_29;
wire nandaab_29;
wire nandabb_29;
wire nandaabb_29;
wire nandab_30;
wire nandaab_30;
wire nandabb_30;
wire nandaabb_30;
wire nandab_31;
wire nandaab_31;
wire nandabb_31;
wire nandaabb_31;
`NAND nandab0(nandab_0, a[0], b[0]);
`NAND nandaab0(nandaab_0, a[0], nandab_0);
`NAND nandabb0(nandabb_0, nandab_0, b[0]);
`NAND nandaabb0(out[0], nandaab_0, nandabb_0);
`NAND nandab1(nandab_1, a[1], b[1]);
`NAND nandaab1(nandaab_1, a[1], nandab_1);
`NAND nandabb1(nandabb_1, nandab_1, b[1]);
`NAND nandaabb1(out[1], nandaab_1, nandabb_1);
`NAND nandab2(nandab_2, a[2], b[2]);
`NAND nandaab2(nandaab_2, a[2], nandab_2);
`NAND nandabb2(nandabb_2, nandab_2, b[2]);
`NAND nandaabb2(out[2], nandaab_2, nandabb_2);
`NAND nandab3(nandab_3, a[3], b[3]);
`NAND nandaab3(nandaab_3, a[3], nandab_3);
`NAND nandabb3(nandabb_3, nandab_3, b[3]);
`NAND nandaabb3(out[3], nandaab_3, nandabb_3);
`NAND nandab4(nandab_4, a[4], b[4]);
`NAND nandaab4(nandaab_4, a[4], nandab_4);
`NAND nandabb4(nandabb_4, nandab_4, b[4]);
`NAND nandaabb4(out[4], nandaab_4, nandabb_4);
`NAND nandab5(nandab_5, a[5], b[5]);
`NAND nandaab5(nandaab_5, a[5], nandab_5);
`NAND nandabb5(nandabb_5, nandab_5, b[5]);
`NAND nandaabb5(out[5], nandaab_5, nandabb_5);
`NAND nandab6(nandab_6, a[6], b[6]);
`NAND nandaab6(nandaab_6, a[6], nandab_6);
`NAND nandabb6(nandabb_6, nandab_6, b[6]);
`NAND nandaabb6(out[6], nandaab_6, nandabb_6);
`NAND nandab7(nandab_7, a[7], b[7]);
`NAND nandaab7(nandaab_7, a[7], nandab_7);
`NAND nandabb7(nandabb_7, nandab_7, b[7]);
`NAND nandaabb7(out[7], nandaab_7, nandabb_7);
`NAND nandab8(nandab_8, a[8], b[8]);
`NAND nandaab8(nandaab_8, a[8], nandab_8);
`NAND nandabb8(nandabb_8, nandab_8, b[8]);
`NAND nandaabb8(out[8], nandaab_8, nandabb_8);
`NAND nandab9(nandab_9, a[9], b[9]);
`NAND nandaab9(nandaab_9, a[9], nandab_9);
`NAND nandabb9(nandabb_9, nandab_9, b[9]);
`NAND nandaabb9(out[9], nandaab_9, nandabb_9);
`NAND nandab10(nandab_10, a[10], b[10]);
`NAND nandaab10(nandaab_10, a[10], nandab_10);
`NAND nandabb10(nandabb_10, nandab_10, b[10]);
`NAND nandaabb10(out[10], nandaab_10, nandabb_10);
`NAND nandab11(nandab_11, a[11], b[11]);
`NAND nandaab11(nandaab_11, a[11], nandab_11);
`NAND nandabb11(nandabb_11, nandab_11, b[11]);
`NAND nandaabb11(out[11], nandaab_11, nandabb_11);
`NAND nandab12(nandab_12, a[12], b[12]);
`NAND nandaab12(nandaab_12, a[12], nandab_12);
`NAND nandabb12(nandabb_12, nandab_12, b[12]);
`NAND nandaabb12(out[12], nandaab_12, nandabb_12);
`NAND nandab13(nandab_13, a[13], b[13]);
`NAND nandaab13(nandaab_13, a[13], nandab_13);
`NAND nandabb13(nandabb_13, nandab_13, b[13]);
`NAND nandaabb13(out[13], nandaab_13, nandabb_13);
`NAND nandab14(nandab_14, a[14], b[14]);
`NAND nandaab14(nandaab_14, a[14], nandab_14);
`NAND nandabb14(nandabb_14, nandab_14, b[14]);
`NAND nandaabb14(out[14], nandaab_14, nandabb_14);
`NAND nandab15(nandab_15, a[15], b[15]);
`NAND nandaab15(nandaab_15, a[15], nandab_15);
`NAND nandabb15(nandabb_15, nandab_15, b[15]);
`NAND nandaabb15(out[15], nandaab_15, nandabb_15);
`NAND nandab16(nandab_16, a[16], b[16]);
`NAND nandaab16(nandaab_16, a[16], nandab_16);
`NAND nandabb16(nandabb_16, nandab_16, b[16]);
`NAND nandaabb16(out[16], nandaab_16, nandabb_16);
`NAND nandab17(nandab_17, a[17], b[17]);
`NAND nandaab17(nandaab_17, a[17], nandab_17);
`NAND nandabb17(nandabb_17, nandab_17, b[17]);
`NAND nandaabb17(out[17], nandaab_17, nandabb_17);
`NAND nandab18(nandab_18, a[18], b[18]);
`NAND nandaab18(nandaab_18, a[18], nandab_18);
`NAND nandabb18(nandabb_18, nandab_18, b[18]);
`NAND nandaabb18(out[18], nandaab_18, nandabb_18);
`NAND nandab19(nandab_19, a[19], b[19]);
`NAND nandaab19(nandaab_19, a[19], nandab_19);
`NAND nandabb19(nandabb_19, nandab_19, b[19]);
`NAND nandaabb19(out[19], nandaab_19, nandabb_19);
`NAND nandab20(nandab_20, a[20], b[20]);
`NAND nandaab20(nandaab_20, a[20], nandab_20);
`NAND nandabb20(nandabb_20, nandab_20, b[20]);
`NAND nandaabb20(out[20], nandaab_20, nandabb_20);
`NAND nandab21(nandab_21, a[21], b[21]);
`NAND nandaab21(nandaab_21, a[21], nandab_21);
`NAND nandabb21(nandabb_21, nandab_21, b[21]);
`NAND nandaabb21(out[21], nandaab_21, nandabb_21);
`NAND nandab22(nandab_22, a[22], b[22]);
`NAND nandaab22(nandaab_22, a[22], nandab_22);
`NAND nandabb22(nandabb_22, nandab_22, b[22]);
`NAND nandaabb22(out[22], nandaab_22, nandabb_22);
`NAND nandab23(nandab_23, a[23], b[23]);
`NAND nandaab23(nandaab_23, a[23], nandab_23);
`NAND nandabb23(nandabb_23, nandab_23, b[23]);
`NAND nandaabb23(out[23], nandaab_23, nandabb_23);
`NAND nandab24(nandab_24, a[24], b[24]);
`NAND nandaab24(nandaab_24, a[24], nandab_24);
`NAND nandabb24(nandabb_24, nandab_24, b[24]);
`NAND nandaabb24(out[24], nandaab_24, nandabb_24);
`NAND nandab25(nandab_25, a[25], b[25]);
`NAND nandaab25(nandaab_25, a[25], nandab_25);
`NAND nandabb25(nandabb_25, nandab_25, b[25]);
`NAND nandaabb25(out[25], nandaab_25, nandabb_25);
`NAND nandab26(nandab_26, a[26], b[26]);
`NAND nandaab26(nandaab_26, a[26], nandab_26);
`NAND nandabb26(nandabb_26, nandab_26, b[26]);
`NAND nandaabb26(out[26], nandaab_26, nandabb_26);
`NAND nandab27(nandab_27, a[27], b[27]);
`NAND nandaab27(nandaab_27, a[27], nandab_27);
`NAND nandabb27(nandabb_27, nandab_27, b[27]);
`NAND nandaabb27(out[27], nandaab_27, nandabb_27);
`NAND nandab28(nandab_28, a[28], b[28]);
`NAND nandaab28(nandaab_28, a[28], nandab_28);
`NAND nandabb28(nandabb_28, nandab_28, b[28]);
`NAND nandaabb28(out[28], nandaab_28, nandabb_28);
`NAND nandab29(nandab_29, a[29], b[29]);
`NAND nandaab29(nandaab_29, a[29], nandab_29);
`NAND nandabb29(nandabb_29, nandab_29, b[29]);
`NAND nandaabb29(out[29], nandaab_29, nandabb_29);
`NAND nandab30(nandab_30, a[30], b[30]);
`NAND nandaab30(nandaab_30, a[30], nandab_30);
`NAND nandabb30(nandabb_30, nandab_30, b[30]);
`NAND nandaabb30(out[30], nandaab_30, nandabb_30);
`NAND nandab31(nandab_31, a[31], b[31]);
`NAND nandaab31(nandaab_31, a[31], nandab_31);
`NAND nandabb31(nandabb_31, nandab_31, b[31]);
`NAND nandaabb31(out[31], nandaab_31, nandabb_31);
endmodule


// test module for XOR. 

module test_XOR;
reg [31:0] a;
reg [31:0] b;
wire [31:0] out;

Xor32Bit test_XOR(out, a, b);

initial begin
$display("                               Inputs                               |              Outputs             |         Expected Outputs         |");
$display("a                                | b                                | a XOR b                          |");
// Test all one-bit combinations
a=32'b00000000000000000000000000000000; b=32'b00000000000000000000000000000000; #3000
$display("%b | %b | %b | 00000000000000000000000000000000 |", a, b, out);

a=32'b00000000000000000000000000000000; b=32'b00000000000000000000000000000001; #3000
$display("%b | %b | %b | 00000000000000000000000000000001 |", a, b, out);

a=32'b00000000000000000000000000000001; b=32'b00000000000000000000000000000000; #3000
$display("%b | %b | %b | 00000000000000000000000000000001 |", a, b, out);

a=32'b00000000000000000000000000000001; b=32'b00000000000000000000000000000001; #3000
$display("%b | %b | %b | 00000000000000000000000000000000 |", a, b, out);

//Test ones handling
a=32'b11111111111111111111111111111111; b=32'b11111111111111111111111111111111; #3000
$display("%b | %b | %b | 00000000000000000000000000000000 |", a, b, out);

a=32'b00000000000000000000000000000000; b=32'b11111111111111111111111111111111; #3000
$display("%b | %b | %b | 11111111111111111111111111111111 |", a, b, out);

// "Interlaced" inputs
a=32'b10101010101010101010101010101010; b=32'b01010101010101010101010101010101; #3000
$display("%b | %b | %b | 11111111111111111111111111111111 |", a, b, out);

a=32'b00000000000000000000000000000011; b=32'b00000000000000000000000000000100; #3000
$display("%b | %b | %b | 00000000000000000000000000000111 |", a, b, out);

a=32'b00110100111110110101111000111000; b=32'b01011011000111110001100010010011; #3000
$display("%b | %b | %b | 01101111111001000100011010101011 |", a, b, out);

a=32'b00000000000000000000000000000011; b=32'b00000000000011000000000000000011; #3000
$display("%b | %b | %b | 00000000000011000000000000000000 |", a, b, out);

end
endmodule


//Module for the AND Operation. Calculated And using Nand and Not. 


module AND32Bit
(
 	output[31:0]out,
	input[31:0] a,
	input[31:0] b
);
//To get and, did not nand
wire nand_0;
wire nand_1;
wire nand_2;
wire nand_3;
wire nand_4;
wire nand_5;
wire nand_6;
wire nand_7;
wire nand_8;
wire nand_9;
wire nand_10;
wire nand_11;
wire nand_12;
wire nand_13;
wire nand_14;
wire nand_15;
wire nand_16;
wire nand_17;
wire nand_18;
wire nand_19;
wire nand_20;
wire nand_21;
wire nand_22;
wire nand_23;
wire nand_24;
wire nand_25;
wire nand_26;
wire nand_27;
wire nand_28;
wire nand_29;
wire nand_30;
wire nand_31;
`NAND nand0(nand_0, a[0], b[0]);
`NOT and0(out[0], nand_0);
`NAND nand1(nand_1, a[1], b[1]);
`NOT and1(out[1], nand_1);
`NAND nand2(nand_2, a[2], b[2]);
`NOT and2(out[2], nand_2);
`NAND nand3(nand_3, a[3], b[3]);
`NOT and3(out[3], nand_3);
`NAND nand4(nand_4, a[4], b[4]);
`NOT and4(out[4], nand_4);
`NAND nand5(nand_5, a[5], b[5]);
`NOT and5(out[5], nand_5);
`NAND nand6(nand_6, a[6], b[6]);
`NOT and6(out[6], nand_6);
`NAND nand7(nand_7, a[7], b[7]);
`NOT and7(out[7], nand_7);
`NAND nand8(nand_8, a[8], b[8]);
`NOT and8(out[8], nand_8);
`NAND nand9(nand_9, a[9], b[9]);
`NOT and9(out[9], nand_9);
`NAND nand10(nand_10, a[10], b[10]);
`NOT and10(out[10], nand_10);
`NAND nand11(nand_11, a[11], b[11]);
`NOT and11(out[11], nand_11);
`NAND nand12(nand_12, a[12], b[12]);
`NOT and12(out[12], nand_12);
`NAND nand13(nand_13, a[13], b[13]);
`NOT and13(out[13], nand_13);
`NAND nand14(nand_14, a[14], b[14]);
`NOT and14(out[14], nand_14);
`NAND nand15(nand_15, a[15], b[15]);
`NOT and15(out[15], nand_15);
`NAND nand16(nand_16, a[16], b[16]);
`NOT and16(out[16], nand_16);
`NAND nand17(nand_17, a[17], b[17]);
`NOT and17(out[17], nand_17);
`NAND nand18(nand_18, a[18], b[18]);
`NOT and18(out[18], nand_18);
`NAND nand19(nand_19, a[19], b[19]);
`NOT and19(out[19], nand_19);
`NAND nand20(nand_20, a[20], b[20]);
`NOT and20(out[20], nand_20);
`NAND nand21(nand_21, a[21], b[21]);
`NOT and21(out[21], nand_21);
`NAND nand22(nand_22, a[22], b[22]);
`NOT and22(out[22], nand_22);
`NAND nand23(nand_23, a[23], b[23]);
`NOT and23(out[23], nand_23);
`NAND nand24(nand_24, a[24], b[24]);
`NOT and24(out[24], nand_24);
`NAND nand25(nand_25, a[25], b[25]);
`NOT and25(out[25], nand_25);
`NAND nand26(nand_26, a[26], b[26]);
`NOT and26(out[26], nand_26);
`NAND nand27(nand_27, a[27], b[27]);
`NOT and27(out[27], nand_27);
`NAND nand28(nand_28, a[28], b[28]);
`NOT and28(out[28], nand_28);
`NAND nand29(nand_29, a[29], b[29]);
`NOT and29(out[29], nand_29);
`NAND nand30(nand_30, a[30], b[30]);
`NOT and30(out[30], nand_30);
`NAND nand31(nand_31, a[31], b[31]);
`NOT and31(out[31], nand_31);
endmodule


// test module for AND. 

module test_AND;

reg [31:0] a;
reg [31:0] b;
wire [31:0] out;

AND32Bit test_AND(out, a, b);

initial begin
$display("                               Inputs                               |              Outputs             |         Expected Outputs         |");
$display("a                                | b                                | a AND b                          |");
// Test all one-bit combinations
a=32'b00000000000000000000000000000000; b=32'b00000000000000000000000000000000; #3000
$display("%b | %b | %b | 00000000000000000000000000000000 |", a, b, out);

a=32'b00000000000000000000000000000000; b=32'b00000000000000000000000000000001; #3000
$display("%b | %b | %b | 00000000000000000000000000000000 |", a, b, out);

a=32'b00000000000000000000000000000001; b=32'b00000000000000000000000000000000; #3000
$display("%b | %b | %b | 00000000000000000000000000000000 |", a, b, out);

a=32'b00000000000000000000000000000001; b=32'b00000000000000000000000000000001; #3000
$display("%b | %b | %b | 00000000000000000000000000000001 |", a, b, out);

//Test ones handling
a=32'b11111111111111111111111111111111; b=32'b11111111111111111111111111111111; #3000
$display("%b | %b | %b | 11111111111111111111111111111111 |", a, b, out);

a=32'b00000000000000000000000000000000; b=32'b11111111111111111111111111111111; #3000
$display("%b | %b | %b | 00000000000000000000000000000000 |", a, b, out);

// "Interlaced" inputs
a=32'b10101010101010101010101010101010; b=32'b01010101010101010101010101010101; #3000
$display("%b | %b | %b | 00000000000000000000000000000000 |", a, b, out);

a=32'b00000000000000000000000000000011; b=32'b00000000000000000000000000000100; #3000
$display("%b | %b | %b | 00000000000000000000000000000000 |", a, b, out);

a=32'b00110100111110110101111000111000; b=32'b01011011000111110001100010010011; #3000
$display("%b | %b | %b | 00010000000110110001100000010000 |", a, b, out);

a=32'b00000000000000000000000000000011; b=32'b00000000000011000000000000000011; #3000
$display("%b | %b | %b | 00000000000000000000000000000011 |", a, b, out);

end
endmodule

//Module for the NAND Operation. Calculated Nand using just the Nand gate.

module NAND32Bit
(
 	output[31:0]out,
	input[31:0] a,
	input[31:0] b
);
`NAND nand0(out[0], a[0], b[0]);
`NAND nand1(out[1], a[1], b[1]);
`NAND nand2(out[2], a[2], b[2]);
`NAND nand3(out[3], a[3], b[3]);
`NAND nand4(out[4], a[4], b[4]);
`NAND nand5(out[5], a[5], b[5]);
`NAND nand6(out[6], a[6], b[6]);
`NAND nand7(out[7], a[7], b[7]);
`NAND nand8(out[8], a[8], b[8]);
`NAND nand9(out[9], a[9], b[9]);
`NAND nand10(out[10], a[10], b[10]);
`NAND nand11(out[11], a[11], b[11]);
`NAND nand12(out[12], a[12], b[12]);
`NAND nand13(out[13], a[13], b[13]);
`NAND nand14(out[14], a[14], b[14]);
`NAND nand15(out[15], a[15], b[15]);
`NAND nand16(out[16], a[16], b[16]);
`NAND nand17(out[17], a[17], b[17]);
`NAND nand18(out[18], a[18], b[18]);
`NAND nand19(out[19], a[19], b[19]);
`NAND nand20(out[20], a[20], b[20]);
`NAND nand21(out[21], a[21], b[21]);
`NAND nand22(out[22], a[22], b[22]);
`NAND nand23(out[23], a[23], b[23]);
`NAND nand24(out[24], a[24], b[24]);
`NAND nand25(out[25], a[25], b[25]);
`NAND nand26(out[26], a[26], b[26]);
`NAND nand27(out[27], a[27], b[27]);
`NAND nand28(out[28], a[28], b[28]);
`NAND nand29(out[29], a[29], b[29]);
`NAND nand30(out[30], a[30], b[30]);
`NAND nand31(out[31], a[31], b[31]);
endmodule




// test module for NAND. 

module test_NAND;

reg [31:0] a;
reg [31:0] b;
wire [31:0] out;

NAND32Bit test_NAND(out, a, b);
// 32-bit NAND has inputs a, b ; outputs out
// Definte I/O wires and regs below

initial begin
$display("                               Inputs                               |              Outputs             |         Expected Outputs         |");
$display("a                                | b                                | a NAND b                         |");
// Test all one-bit combinations
a=32'b00000000000000000000000000000000; b=32'b00000000000000000000000000000000; #3000
$display("%b | %b | %b | 11111111111111111111111111111111 |", a, b, out);

a=32'b00000000000000000000000000000000; b=32'b00000000000000000000000000000001; #3000
$display("%b | %b | %b | 11111111111111111111111111111111 |", a, b, out);

a=32'b00000000000000000000000000000001; b=32'b00000000000000000000000000000000; #3000
$display("%b | %b | %b | 11111111111111111111111111111111 |", a, b, out);

a=32'b00000000000000000000000000000001; b=32'b00000000000000000000000000000001; #3000
$display("%b | %b | %b | 11111111111111111111111111111110 |", a, b, out);

//Test ones handling
a=32'b11111111111111111111111111111111; b=32'b11111111111111111111111111111111; #3000
$display("%b | %b | %b | 00000000000000000000000000000000 |", a, b, out);

a=32'b00000000000000000000000000000000; b=32'b11111111111111111111111111111111; #3000
$display("%b | %b | %b | 11111111111111111111111111111111 |", a, b, out);

// "Interlaced" inputs
a=32'b10101010101010101010101010101010; b=32'b01010101010101010101010101010101; #3000
$display("%b | %b | %b | 11111111111111111111111111111111 |", a, b, out);

a=32'b00000000000000000000000000000011; b=32'b00000000000000000000000000000100; #3000
$display("%b | %b | %b | 11111111111111111111111111111111 |", a, b, out);

a=32'b00110100111110110101111000111000; b=32'b01011011000111110001100010010011; #3000
$display("%b | %b | %b | 11101111111001001110011111101111 |", a, b, out);

a=32'b00000000000000000000000000000011; b=32'b00000000000011000000000000000011; #3000
$display("%b | %b | %b | 11111111111111111111111111111100 |", a, b, out);

end
endmodule
