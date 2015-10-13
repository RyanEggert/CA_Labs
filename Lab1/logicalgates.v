module test_OR;
// 32-bit OR has inputs a, b ; outputs out
// Definte I/O wires and regs below


// Instantiate 32-bit OR here
<OR module name> test_OR(out, a, b);
initial begin
$display("                               Inputs                               |         Expected Outputs         |              Outputs             |");
$display("a                                | b                                | a OR b                           |");
a=32'b00000000000000000000000000000000; b=32'b00000000000000000000000000000000; 
$display("%b | %b | %b | 00000000000000000000000000000000 |", a, b, out);

a=32'b00000000000000000000000000000000; b=32'b00000000000000000000000000000001; 
$display("%b | %b | %b | 00000000000000000000000000000001 |", a, b, out);

a=32'b00000000000000000000000000000001; b=32'b00000000000000000000000000000000; 
$display("%b | %b | %b | 00000000000000000000000000000001 |", a, b, out);

a=32'b00000000000000000000000000000001; b=32'b00000000000000000000000000000001; 
$display("%b | %b | %b | 00000000000000000000000000000001 |", a, b, out);

a=32'b11111111111111111111111111111111; b=32'b11111111111111111111111111111111; 
$display("%b | %b | %b | 11111111111111111111111111111111 |", a, b, out);

a=32'b00000000000000000000000000000000; b=32'b11111111111111111111111111111111; 
$display("%b | %b | %b | 11111111111111111111111111111111 |", a, b, out);

a=32'b10101010101010101010101010101010; b=32'b01010101010101010101010101010101; 
$display("%b | %b | %b | 11111111111111111111111111111111 |", a, b, out);

a=32'b00000000000000000000000000000011; b=32'b00000000000000000000000000000100; 
$display("%b | %b | %b | 00000000000000000000000000000111 |", a, b, out);

a=32'b00110100111110110101111000111000; b=32'b01011011000111110001100010010011; 
$display("%b | %b | %b | 01111111111111110101111010111011 |", a, b, out);

a=32'b00000000000000000000000000000011; b=32'b00000000000011000000000000000011; 
$display("%b | %b | %b | 00000000000011000000000000000011 |", a, b, out);

end
endmodule




module test_NOR;
// 32-bit NOR has inputs a, b ; outputs out
// Definte I/O wires and regs below


// Instantiate 32-bit NOR here
<NOR module name> test_NOR(out, a, b);
initial begin
$display("                               Inputs                               |         Expected Outputs         |              Outputs             |");
$display("a                                | b                                | a NOR b                          |");
a=32'b00000000000000000000000000000000; b=32'b00000000000000000000000000000000; 
$display("%b | %b | %b | 11111111111111111111111111111111 |", a, b, out);

a=32'b00000000000000000000000000000000; b=32'b00000000000000000000000000000001; 
$display("%b | %b | %b | 11111111111111111111111111111110 |", a, b, out);

a=32'b00000000000000000000000000000001; b=32'b00000000000000000000000000000000; 
$display("%b | %b | %b | 11111111111111111111111111111110 |", a, b, out);

a=32'b00000000000000000000000000000001; b=32'b00000000000000000000000000000001; 
$display("%b | %b | %b | 11111111111111111111111111111110 |", a, b, out);

a=32'b11111111111111111111111111111111; b=32'b11111111111111111111111111111111; 
$display("%b | %b | %b | 00000000000000000000000000000000 |", a, b, out);

a=32'b00000000000000000000000000000000; b=32'b11111111111111111111111111111111; 
$display("%b | %b | %b | 00000000000000000000000000000000 |", a, b, out);

a=32'b10101010101010101010101010101010; b=32'b01010101010101010101010101010101; 
$display("%b | %b | %b | 00000000000000000000000000000000 |", a, b, out);

a=32'b00000000000000000000000000000011; b=32'b00000000000000000000000000000100; 
$display("%b | %b | %b | 11111111111111111111111111111000 |", a, b, out);

a=32'b00110100111110110101111000111000; b=32'b01011011000111110001100010010011; 
$display("%b | %b | %b | 10000000000000001010000101000100 |", a, b, out);

a=32'b00000000000000000000000000000011; b=32'b00000000000011000000000000000011; 
$display("%b | %b | %b | 11111111111100111111111111111100 |", a, b, out);

end
endmodule




module test_XOR;
// 32-bit XOR has inputs a, b ; outputs out
// Definte I/O wires and regs below


// Instantiate 32-bit XOR here
<XOR module name> test_XOR(out, a, b);
initial begin
$display("                               Inputs                               |         Expected Outputs         |              Outputs             |");
$display("a                                | b                                | a XOR b                          |");
a=32'b00000000000000000000000000000000; b=32'b00000000000000000000000000000000; 
$display("%b | %b | %b | 00000000000000000000000000000000 |", a, b, out);

a=32'b00000000000000000000000000000000; b=32'b00000000000000000000000000000001; 
$display("%b | %b | %b | 00000000000000000000000000000001 |", a, b, out);

a=32'b00000000000000000000000000000001; b=32'b00000000000000000000000000000000; 
$display("%b | %b | %b | 00000000000000000000000000000001 |", a, b, out);

a=32'b00000000000000000000000000000001; b=32'b00000000000000000000000000000001; 
$display("%b | %b | %b | 00000000000000000000000000000000 |", a, b, out);

a=32'b11111111111111111111111111111111; b=32'b11111111111111111111111111111111; 
$display("%b | %b | %b | 00000000000000000000000000000000 |", a, b, out);

a=32'b00000000000000000000000000000000; b=32'b11111111111111111111111111111111; 
$display("%b | %b | %b | 11111111111111111111111111111111 |", a, b, out);

a=32'b10101010101010101010101010101010; b=32'b01010101010101010101010101010101; 
$display("%b | %b | %b | 11111111111111111111111111111111 |", a, b, out);

a=32'b00000000000000000000000000000011; b=32'b00000000000000000000000000000100; 
$display("%b | %b | %b | 00000000000000000000000000000111 |", a, b, out);

a=32'b00110100111110110101111000111000; b=32'b01011011000111110001100010010011; 
$display("%b | %b | %b | 01101111111001000100011010101011 |", a, b, out);

a=32'b00000000000000000000000000000011; b=32'b00000000000011000000000000000011; 
$display("%b | %b | %b | 00000000000011000000000000000000 |", a, b, out);

end
endmodule




module test_XNOR;
// 32-bit XNOR has inputs a, b ; outputs out
// Definte I/O wires and regs below


// Instantiate 32-bit XNOR here
<XNOR module name> test_XNOR(out, a, b);
initial begin
$display("                               Inputs                               |         Expected Outputs         |              Outputs             |");
$display("a                                | b                                | a XNOR b                         |");
a=32'b00000000000000000000000000000000; b=32'b00000000000000000000000000000000; 
$display("%b | %b | %b | 11111111111111111111111111111111 |", a, b, out);

a=32'b00000000000000000000000000000000; b=32'b00000000000000000000000000000001; 
$display("%b | %b | %b | 11111111111111111111111111111110 |", a, b, out);

a=32'b00000000000000000000000000000001; b=32'b00000000000000000000000000000000; 
$display("%b | %b | %b | 11111111111111111111111111111110 |", a, b, out);

a=32'b00000000000000000000000000000001; b=32'b00000000000000000000000000000001; 
$display("%b | %b | %b | 11111111111111111111111111111111 |", a, b, out);

a=32'b11111111111111111111111111111111; b=32'b11111111111111111111111111111111; 
$display("%b | %b | %b | 11111111111111111111111111111111 |", a, b, out);

a=32'b00000000000000000000000000000000; b=32'b11111111111111111111111111111111; 
$display("%b | %b | %b | 00000000000000000000000000000000 |", a, b, out);

a=32'b10101010101010101010101010101010; b=32'b01010101010101010101010101010101; 
$display("%b | %b | %b | 00000000000000000000000000000000 |", a, b, out);

a=32'b00000000000000000000000000000011; b=32'b00000000000000000000000000000100; 
$display("%b | %b | %b | 11111111111111111111111111111000 |", a, b, out);

a=32'b00110100111110110101111000111000; b=32'b01011011000111110001100010010011; 
$display("%b | %b | %b | 10010000000110111011100101010100 |", a, b, out);

a=32'b00000000000000000000000000000011; b=32'b00000000000011000000000000000011; 
$display("%b | %b | %b | 11111111111100111111111111111111 |", a, b, out);

end
endmodule




module test_AND;
// 32-bit AND has inputs a, b ; outputs out
// Definte I/O wires and regs below


// Instantiate 32-bit AND here
<AND module name> test_AND(out, a, b);
initial begin
$display("                               Inputs                               |         Expected Outputs         |              Outputs             |");
$display("a                                | b                                | a AND b                          |");
a=32'b00000000000000000000000000000000; b=32'b00000000000000000000000000000000; 
$display("%b | %b | %b | 00000000000000000000000000000000 |", a, b, out);

a=32'b00000000000000000000000000000000; b=32'b00000000000000000000000000000001; 
$display("%b | %b | %b | 00000000000000000000000000000000 |", a, b, out);

a=32'b00000000000000000000000000000001; b=32'b00000000000000000000000000000000; 
$display("%b | %b | %b | 00000000000000000000000000000000 |", a, b, out);

a=32'b00000000000000000000000000000001; b=32'b00000000000000000000000000000001; 
$display("%b | %b | %b | 00000000000000000000000000000001 |", a, b, out);

a=32'b11111111111111111111111111111111; b=32'b11111111111111111111111111111111; 
$display("%b | %b | %b | 11111111111111111111111111111111 |", a, b, out);

a=32'b00000000000000000000000000000000; b=32'b11111111111111111111111111111111; 
$display("%b | %b | %b | 00000000000000000000000000000000 |", a, b, out);

a=32'b10101010101010101010101010101010; b=32'b01010101010101010101010101010101; 
$display("%b | %b | %b | 00000000000000000000000000000000 |", a, b, out);

a=32'b00000000000000000000000000000011; b=32'b00000000000000000000000000000100; 
$display("%b | %b | %b | 00000000000000000000000000000000 |", a, b, out);

a=32'b00110100111110110101111000111000; b=32'b01011011000111110001100010010011; 
$display("%b | %b | %b | 00010000000110110001100000010000 |", a, b, out);

a=32'b00000000000000000000000000000011; b=32'b00000000000011000000000000000011; 
$display("%b | %b | %b | 00000000000000000000000000000011 |", a, b, out);

end
endmodule




module test_NAND;
// 32-bit NAND has inputs a, b ; outputs out
// Definte I/O wires and regs below


// Instantiate 32-bit NAND here
<NAND module name> test_NAND(out, a, b);
initial begin
$display("                               Inputs                               |         Expected Outputs         |              Outputs             |");
$display("a                                | b                                | a NAND b                         |");
a=32'b00000000000000000000000000000000; b=32'b00000000000000000000000000000000; 
$display("%b | %b | %b | 11111111111111111111111111111111 |", a, b, out);

a=32'b00000000000000000000000000000000; b=32'b00000000000000000000000000000001; 
$display("%b | %b | %b | 11111111111111111111111111111111 |", a, b, out);

a=32'b00000000000000000000000000000001; b=32'b00000000000000000000000000000000; 
$display("%b | %b | %b | 11111111111111111111111111111111 |", a, b, out);

a=32'b00000000000000000000000000000001; b=32'b00000000000000000000000000000001; 
$display("%b | %b | %b | 11111111111111111111111111111110 |", a, b, out);

a=32'b11111111111111111111111111111111; b=32'b11111111111111111111111111111111; 
$display("%b | %b | %b | 00000000000000000000000000000000 |", a, b, out);

a=32'b00000000000000000000000000000000; b=32'b11111111111111111111111111111111; 
$display("%b | %b | %b | 11111111111111111111111111111111 |", a, b, out);

a=32'b10101010101010101010101010101010; b=32'b01010101010101010101010101010101; 
$display("%b | %b | %b | 11111111111111111111111111111111 |", a, b, out);

a=32'b00000000000000000000000000000011; b=32'b00000000000000000000000000000100; 
$display("%b | %b | %b | 11111111111111111111111111111111 |", a, b, out);

a=32'b00110100111110110101111000111000; b=32'b01011011000111110001100010010011; 
$display("%b | %b | %b | 11101111111001001110011111101111 |", a, b, out);

a=32'b00000000000000000000000000000011; b=32'b00000000000011000000000000000011; 
$display("%b | %b | %b | 11111111111111111111111111111100 |", a, b, out);

end
endmodule