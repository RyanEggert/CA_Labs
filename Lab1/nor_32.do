/*do file for nor, runs test function and adds waves for outputs */

vdel -lib work -all
vlib work
vlog -reportprogress 300 -work work logicalgates.v
vsim -voptargs="+acc" test_NOR
add wave -position insertpoint  \
sim:/test_NOR/a \
sim:/test_NOR/b \
sim:/test_NOR/out 
run -all
#wave zoom full