//subtract a from b, if its negative, you know a < b
//the part you care about is the most significant bit of the result and the overflow
//when msb is 1, overflow will only occur when the result is positive (aka a !> b)

module setlessthan(
	input[31:0] a,
	input[31:0] b,
	output carryout = 0,
	output overflow = 0,
	output[31:0] result
);
wire[31:0] sub_sum;	//sum placeholder
wire sub_cout;		//carry out placeholder
wire sub_ovf;		//overflow placehold

FullSubtractor32bit subtract (sub_sum, sub_cout, sub_ovf, a, b);
xor(result[0],sub_ovf,sub_sum[31]);
//making a loop to fill the rest of result with zeros
genvar i;
for(i=1;i<32;i=i+1) begin
assign {result[i]} = 0;
end
endmodule