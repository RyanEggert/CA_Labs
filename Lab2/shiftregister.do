vlog -reportprogress 300 -work work shiftregister.t.v shiftregister.v 
vsim -voptargs="+acc" testshiftregister

run 10000

