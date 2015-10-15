vdel -lib work -all
vlib work
vlog -reportprogress 300 -work work logicalgates.v
vsim -voptargs="+acc" test_OR
add wave -position insertpoint  \
sim:/test_OR/a \
sim:/test_OR/b \
sim:/test_OR/out 
run -all
#wave zoom full