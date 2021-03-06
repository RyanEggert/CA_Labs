// define gates with delays
`define AND and #50
`define OR or #50
`define NOT not #50
`define XOR xor #50
`define XNOR xnor #50

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


module FullAdder4bit
(
  output[3:0] sum,  // 4-bit 2's complement sum of a and b
  output carryout,  // Carry out of the summation of a and b
  output overflow,  // True if the calculation resulted in an overflow
  input[3:0] a,     // First operand (4-bit) in 2's complement format
  input[3:0] b      // Second operand (4-bit) in 2's complement format
);

wire adder0_cout;
wire adder1_cout;
wire adder2_cout;
wire carryin_null = 0;
// A four-bit full adder is comprised of four one-bit adders
FullAdder1bit adder0(sum[0], adder0_cout, a[0], b[0], carryin_null); // First addition operation has no carryin
FullAdder1bit adder1(sum[1], adder1_cout, a[1], b[1], adder0_cout);
FullAdder1bit adder2(sum[2], adder2_cout, a[2], b[2], adder1_cout);
FullAdder1bit adder3(sum[3], carryout, a[3], b[3], adder2_cout);

// If the adder3 carryin != adder3 carryout, there is an overflow error
// cin cout overflow?
//   0    0 0
//   0    1 1
//   1    0 1
//   1    1 0
// The above is an XOR gate
`XOR overflowxor (overflow, adder2_cout, carryout);
endmodule

module testFullAdder1bit;
reg a, b, carryin;
wire str_sum, str_carryout;
wire beh_sum, beh_carryout;
FullAdder1bit str_adder(str_sum, str_carryout, a, b, carryin);

initial begin
// Begin Combined Testbench
// Completely test behavioral and structural adders
$display(" Inputs  | Structural | Expected");
$display("A B C_In | Sum C_Out  |Sum C_Out");
// At most, signal travels through 3 gates. Set durations to a bit over 3 times the gate delay.
carryin=0;a=0;b=0; #175 
$display("%b %b %b    |  %b  %b      | 0   0", a, b, carryin, str_sum, str_carryout);
carryin=1;a=0;b=0; #175 
$display("%b %b %b    |  %b  %b      | 1   0", a, b, carryin, str_sum, str_carryout);
carryin=0;a=0;b=1; #175 
$display("%b %b %b    |  %b  %b      | 1   0", a, b, carryin, str_sum, str_carryout);
carryin=1;a=0;b=1; #175 
$display("%b %b %b    |  %b  %b      | 0   1", a, b, carryin, str_sum, str_carryout);
carryin=0;a=1;b=0; #175 
$display("%b %b %b    |  %b  %b      | 1   0", a, b, carryin, str_sum, str_carryout);
carryin=1;a=1;b=0; #175 
$display("%b %b %b    |  %b  %b      | 0   1", a, b, carryin, str_sum, str_carryout);
carryin=0;a=1;b=1; #175 
$display("%b %b %b    |  %b  %b      | 0   1", a, b, carryin, str_sum, str_carryout);
carryin=1;a=1;b=1; #175 
$display("%b %b %b    |  %b  %b      | 1   1", a, b, carryin, str_sum, str_carryout);
// Reference truth table verified from
// http://www.electronicshub.org/wp-content/uploads/2014/08/Truth-Table-for-Full-Adder.jpg
end
endmodule

module testFullAdder4bit;
reg [3:0] a;
reg [3:0] b;
wire [3:0] sum;
wire carryout;
wire overflow;

FullAdder4bit test_adder(sum, carryout, overflow, a, b);
// wire carryin;
// wire str_sum, str_carryout;
// wire beh_sum, beh_carryout;
// FullAdder1bit str_adder(str_sum, str_carryout, a, b, carryin);

initial begin
$display("Run adder");
// Begin Combined Testbench
// Completely test behavioral and structural adders
$display(" Inputs   |       Outputs          | Expected");
$display("A    B    | Sum    C_Out Overflow  | Sum    C_Out Overflow  ");
// 0+0
a=4'b0000;b=4'b0000; #1000
$display("%b %b | %b   %b     %b         | 0000   0     0         ", a, b, sum, carryout, overflow);

//0+1
a=4'b0000;b=4'b0001; #1000
$display("%b %b | %b   %b     %b         | 0001   0     0         ", a, b, sum, carryout, overflow);

// 0+-1
a=4'b0000;b=4'b1111; #1000
$display("%b %b | %b   %b     %b         | 1111   0     0         ", a, b, sum, carryout, overflow);

// 1 + 1 
a=4'b0001;b=4'b0001; #1000
$display("%b %b | %b   %b     %b         | 0010   0     0         ", a, b, sum, carryout, overflow);

// 1 + -1
a=4'b0001;b=4'b1111; #1000
$display("%b %b | %b   %b     %b         | 0000   1     0         ", a, b, sum, carryout, overflow);

// 1 + 7 
a=4'b0001;b=4'b0111; #1000
$display("%b %b | %b   %b     %b         | 1000   0     1         ", a, b, sum, carryout, overflow);

// 1 + -2
a=4'b0001;b=4'b1110; #1000
$display("%b %b | %b   %b     %b         | 1111   0     0         ", a, b, sum, carryout, overflow);

// 2 + -2
a=4'b0010;b=4'b1110; #1000
$display("%b %b | %b   %b     %b         | 0000   1     0         ", a, b, sum, carryout, overflow);

// 2 + 4
a=4'b0010;b=4'b0100; #1000
$display("%b %b | %b   %b     %b         | 0110   0     0         ", a, b, sum, carryout, overflow);

// 3 + 3
a=4'b0011;b=4'b0011; #1000
$display("%b %b | %b   %b     %b         | 0110   0     0         ", a, b, sum, carryout, overflow);


// 3 + 4
a=4'b0011;b=4'b0100; #1000
$display("%b %b | %b   %b     %b         | 0111   0     0         ", a, b, sum, carryout, overflow);

// 3 + 5
a=4'b0011;b=4'b0101; #1000
$display("%b %b | %b   %b     %b         | 1000   0     1         ", a, b, sum, carryout, overflow);

// 3 + -2
a=4'b0011;b=4'b1110; #1000
$display("%b %b | %b   %b     %b         | 0001   1     0         ", a, b, sum, carryout, overflow);

// 3 + -2
a=4'b0011;b=4'b1110; #1000
$display("%b %b | %b   %b     %b         | 0001   1     0         ", a, b, sum, carryout, overflow);

// 4 + 4
a=4'b0100;b=4'b0100; #1000
$display("%b %b | %b   %b     %b         | 1000   0     1         ", a, b, sum, carryout, overflow);

// 5 + 5
a=4'b0101;b=4'b0101; #1000
$display("%b %b | %b   %b     %b         | 1010   0     1         ", a, b, sum, carryout, overflow);

// 5 + -3
a=4'b0101;b=4'b1101; #1000
$display("%b %b | %b   %b     %b         | 0010   1     0         ", a, b, sum, carryout, overflow);

// 5 + -7
a=4'b0101;b=4'b1001; #1000
$display("%b %b | %b   %b     %b         | 1110   0     0         ", a, b, sum, carryout, overflow);

// 7 + 7
a=4'b0111;b=4'b0111; #1000
$display("%b %b | %b   %b     %b         | 1110   0     1         ", a, b, sum, carryout, overflow);

// 7 + -7
a=4'b0111;b=4'b1001; #1000
$display("%b %b | %b   %b     %b         | 0000   1     1         ", a, b, sum, carryout, overflow);

// -1 + -1
a=4'b1111;b=4'b1111; #1000
$display("%b %b | %b   %b     %b         | 1110   1     0         ", a, b, sum, carryout, overflow);

// -1 + -7
a=4'b1111;b=4'b1001; #1000
$display("%b %b | %b   %b     %b         | 1001   1     0         ", a, b, sum, carryout, overflow);

// -1 + -8
a=4'b1111;b=4'b1000; #1000
$display("%b %b | %b   %b     %b         | 0111   1     1         ", a, b, sum, carryout, overflow);

// -3 + -3
a=4'b1101;b=4'b1101; #1000
$display("%b %b | %b   %b     %b         | 1010   1     0         ", a, b, sum, carryout, overflow);

// -4 + -4
a=4'b1100;b=4'b1100; #1000
$display("%b %b | %b   %b     %b         | 1000   1     0         ", a, b, sum, carryout, overflow);

// -5 + -5
a=4'b1011;b=4'b1011; #1000
$display("%b %b | %b   %b     %b         | 0110   1     1         ", a, b, sum, carryout, overflow);

// -8 + -8
a=4'b1000;b=4'b1000; #1000
$display("%b %b | %b   %b     %b         | 0000   1     1         ", a, b, sum, carryout, overflow);



// carryin=1;a=0;b=0; #175 
// $display("%b %b %b    |  %b  %b      | 1   0", a, b, carryin, str_sum, str_carryout);
// carryin=0;a=0;b=1; #175 
// $display("%b %b %b    |  %b  %b      | 1   0", a, b, carryin, str_sum, str_carryout);
// carryin=1;a=0;b=1; #175 
// $display("%b %b %b    |  %b  %b      | 0   1", a, b, carryin, str_sum, str_carryout);
// carryin=0;a=1;b=0; #175 
// $display("%b %b %b    |  %b  %b      | 1   0", a, b, carryin, str_sum, str_carryout);
// carryin=1;a=1;b=0; #175 
// $display("%b %b %b    |  %b  %b      | 0   1", a, b, carryin, str_sum, str_carryout);
// carryin=0;a=1;b=1; #175 
// $display("%b %b %b    |  %b  %b      | 0   1", a, b, carryin, str_sum, str_carryout);
// carryin=1;a=1;b=1; #175 
// $display("%b %b %b    |  %b  %b      | 1   1", a, b, carryin, str_sum, str_carryout);
// // Reference truth table verified from
// // http://www.electronicshub.org/wp-content/uploads/2014/08/Truth-Table-for-Full-Adder.jpg
end
endmodule