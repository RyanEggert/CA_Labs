vdel -lib work -all
vlib work
vlog -reportprogress 300 -work work fsm.v fsm.t.v
vsim -voptargs="+acc" testFSM

run 1000