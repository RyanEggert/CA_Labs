module Subtractor1bit
(
	output twos;
	input a;
	input b;

);

b = not(b) + b'0001;

endmodule