vdel -lib work -all
vlib work
vlog -reportprogress 300 -work work inputconditioner.v inputconditioner.t.v
vsim -voptargs="+acc" testConditioner
add wave -position insertpoint  \
sim:/dut/clk \
sim:/dut/noisysignal \
sim:/dut/conditioned \
sim:/dut/positiveedge \
sim:/dut/negativeedge 
add wave -position insertpoint  \
sim:/dut/conditioned \
sim:/dut/synchronizer0 \
sim:/dut/synchronizer1

run 10000
wave zoom full