vdel -lib work -all
vlib work
vlog -reportprogress 300 -work work subtractor.v
vsim -voptargs="+acc" test_subtractor32
run -all