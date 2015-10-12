Subtractor32bit(
	output[31:0]sum,
	output carryout,
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
wire carryin_null = 0;
Subtractor1bit subtract0(sum[0], subtract0_cout, a[0], b[0], carryin_null);
Subtractor1bit subtract1(sum[1], subtract1_cout, a[1], b[1], subtract0_cout);
Subtractor1bit subtract2(sum[2], subtract2_cout, a[2], b[2], subtract1_cout);
Subtractor1bit subtract3(sum[3], subtract3_cout, a[3], b[3], subtract2_cout);
Subtractor1bit subtract4(sum[4], subtract4_cout, a[4], b[4], subtract3_cout);
Subtractor1bit subtract5(sum[5], subtract5_cout, a[5], b[5], subtract4_cout);
Subtractor1bit subtract6(sum[6], subtract6_cout, a[6], b[6], subtract5_cout);
Subtractor1bit subtract7(sum[7], subtract7_cout, a[7], b[7], subtract6_cout);
Subtractor1bit subtract8(sum[8], subtract8_cout, a[8], b[8], subtract7_cout);
Subtractor1bit subtract9(sum[9], subtract9_cout, a[9], b[9], subtract8_cout);
Subtractor1bit subtract10(sum[10], subtract10_cout, a[10], b[10], subtract9_cout);
Subtractor1bit subtract11(sum[11], subtract11_cout, a[11], b[11], subtract10_cout);
Subtractor1bit subtract12(sum[12], subtract12_cout, a[12], b[12], subtract11_cout);
Subtractor1bit subtract13(sum[13], subtract13_cout, a[13], b[13], subtract12_cout);
Subtractor1bit subtract14(sum[14], subtract14_cout, a[14], b[14], subtract13_cout);
Subtractor1bit subtract15(sum[15], subtract15_cout, a[15], b[15], subtract14_cout);
Subtractor1bit subtract16(sum[16], subtract16_cout, a[16], b[16], subtract15_cout);
Subtractor1bit subtract17(sum[17], subtract17_cout, a[17], b[17], subtract16_cout);
Subtractor1bit subtract18(sum[18], subtract18_cout, a[18], b[18], subtract17_cout);
Subtractor1bit subtract19(sum[19], subtract19_cout, a[19], b[19], subtract18_cout);
Subtractor1bit subtract20(sum[20], subtract20_cout, a[20], b[20], subtract19_cout);
Subtractor1bit subtract21(sum[21], subtract21_cout, a[21], b[21], subtract20_cout);
Subtractor1bit subtract22(sum[22], subtract22_cout, a[22], b[22], subtract21_cout);
Subtractor1bit subtract23(sum[23], subtract23_cout, a[23], b[23], subtract22_cout);
Subtractor1bit subtract24(sum[24], subtract24_cout, a[24], b[24], subtract23_cout);
Subtractor1bit subtract25(sum[25], subtract25_cout, a[25], b[25], subtract24_cout);
Subtractor1bit subtract26(sum[26], subtract26_cout, a[26], b[26], subtract25_cout);
Subtractor1bit subtract27(sum[27], subtract27_cout, a[27], b[27], subtract26_cout);
Subtractor1bit subtract28(sum[28], subtract28_cout, a[28], b[28], subtract27_cout);
Subtractor1bit subtract29(sum[29], subtract29_cout, a[29], b[29], subtract28_cout);
Subtractor1bit subtract30(sum[30], subtract30_cout, a[30], b[30], subtract29_cout);
Subtractor1bit subtract31(sum[31], carryout, a[31], b[31], subtract30_cout);
`XOR overflowxor (overflow, subtract30_cout, carryout);
end module