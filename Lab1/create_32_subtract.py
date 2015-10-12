"""
create_32_subtract.py
Using loops and print statements to write the code for a 32 bit subtractor.
Meg McCauley
October 12, 2015
"""

f = open('subtract_32_generated.v','w')
#the number of bits that are needed
bits = 32

#prints the initialization of all variables
f.write("Subtractor"+str(bits)+"bit(\n\
	output["+str(bits-1)+":0]sum,\n\
	output carryout,\n\
	input["+str(bits-1)+":0] a,\n\
	input["+str(bits-1)+":0] b\n\
);\n")

#loops through the number of bits and creates an "subtract#_cout" wire for each one
for i in range(bits):
	f.write("wire subtract"+str(i)+"_cout;\n")
#initializes the carryin wire
f.write("wire carryin_null = 0;\n")
#adder0 needs a special case because it has the carryin_null wire
f.write("Subtractor1bit subtract0(sum[0], subtract0_cout, a[0], b[0], carryin_null);\n");
#loops through the number of bits and strings together that many single bit subtractors
for j in range(1,bits-1):
	f.write("Subtractor1bit subtract" + str(j) + "(sum[" + str(j) + "], subtract" + str(j) + "_cout, a[" + str(j) + "], b[" + str(j) + "], subtract" + str(j-1) + "_cout);\n")
#single print statement to deal with overflow
f.write("Subtractor1bit subtract" + str(bits-1) + "(sum[" + str(bits-1) + "], carryout, a[" + str(bits-1) + "], b[" + str(bits-1) + "], subtract" + str(bits-2) + "_cout);\n")

#edge case to grab the last overflow and XOR it
f.write("`XOR overflowxor (overflow, subtract"+ str(bits-2)+"_cout, carryout);\n")

#the end
f.write("end module")

f.close()