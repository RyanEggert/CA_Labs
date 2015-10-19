/*do file for and, runs test function and adds waves for outputs */

vdel -lib work -all
vlib work
vlog -reportprogress 300 -work work logicalgates.v
vsim -voptargs="+acc" test_AND
add wave -position insertpoint  \
sim:/test_AND/a \
sim:/test_AND/b \
sim:/test_AND/out 
run -all
#wave zoom full