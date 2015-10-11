"""
create_32_adder.py
Using loops and print statements to write the code for a 32 bit adder.
Created while referencing code from a 4 bit adder composed of 1 bit adders.
Meg McCauley
October 15, 2015- 1 hour (8:30pm-9:30pm)
"""

f = open('32_bit_adder.v','w')
#the number of bits that are needed
bits = 32

#prints the initialization of all variables
f.write("FullAdder"+str(bits)+"bit(\n\
	output["+str(bits-1)+":0]sum,\n\
	output carryout,\n\
	input["+str(bits-1)+":0] a,\n\
	input["+str(bits-1)+":0] b\n\
);\n")

#loops through the number of bits and creates an "adder#_cout" wire for each one
for i in range(bits):
	f.write("wire adder"+str(i)+"_cout;\n")
#initializes the carryin wire
f.write("wire carryin_null = 0;\n")
#loops through the number of bits and strings together that many single bit adders
for j in range(bits-1):
	f.write("FullAdder1bit adder" + str(j) + "(sum[" + str(j) + "], adder" + str(j) + "_cout, a[" + str(j) + "], b[" + str(j) + "], adder" + str(j-1) + "_cout);\n")
#single print statement to deal with overflow
f.write("FullAdder1bit adder" + str(bits-1) + "(sum[" + str(bits-1) + "], carryout, a[" + str(bits-1) + "], b[" + str(bits-1) + "], adder" + str(bits-2) + "_cout);\n")

#edge case to grab the last overflow and XOR it
f.write("`XOR overflowxor (overflow, adder"+ str(bits-2)+"_cout, carryout);\n")

#the end
f.write("end module")

f.close()