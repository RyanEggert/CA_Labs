vdel -lib work -all
vlib work
vlog -reportprogress 300 -work work setlessthan.v
vsim -voptargs="+acc" test_slt32
run -all