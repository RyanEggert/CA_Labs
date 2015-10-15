vdel -lib work -all
vlib work
vlog -reportprogress 300 -work work alu.v adder_32.v
vsim -voptargs="+acc" test_ALUcontrolLUT
run -all