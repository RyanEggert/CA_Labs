/*do file for xor, runs test function and adds waves for outputs */

vdel -lib work -all
vlib work
vlog -reportprogress 300 -work work logicalgates.v
vsim -voptargs="+acc" test_XOR
add wave -position insertpoint  \
sim:/test_XOR/a \
sim:/test_XOR/b \
sim:/test_XOR/out 
run -all
#wave zoom full