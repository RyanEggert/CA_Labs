vdel -lib work -all
vlib work
vlog -reportprogress 300 -work work fsm.v fsm.t.v
vsim -voptargs="+acc" testFSM

add wave -position insertpoint  \
sim:/dut/cs_pin \
sim:/dut/clk \
sim:/dut/sclk_pin \
sim:/dut/rw \
sim:/dut/current_state \
sim:/dut/reset_counter \
sim:/dut/counter

run 20000
wave zoom full