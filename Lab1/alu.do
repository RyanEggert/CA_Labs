vdel -lib work -all
vlib work
vlog -reportprogress 300 -work work alu.v adder_32.v logicalgates.v subtractor.v setlessthan.v
vsim -voptargs="+acc" test_alu
run -all