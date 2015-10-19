/*do file for nand, runs test function and adds waves for outputs */

vdel -lib work -all
vlib work
vlog -reportprogress 300 -work work logicalgates.v
vsim -voptargs="+acc" test_NAND
add wave -position insertpoint  \
sim:/test_NAND/a \
sim:/test_NAND/b \
sim:/test_NAND/out 
run -all
#wave zoom full