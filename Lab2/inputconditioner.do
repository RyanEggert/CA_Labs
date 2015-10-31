vdel -lib work -all
vlib work
vlog -reportprogress 300 -work work inputconditioner.v inputconditioner.t.v
vsim -voptargs="+acc" testConditioner
run 10000