vdel -lib work -all
vlib work
vlog -reportprogress 300 -work work thirty_two_bit_adder.v
vsim -voptargs="+acc" test_adder32
add wave -position insertpoint  \
sim:/test_adder32/a \
sim:/test_adder32/b \
sim:/test_adder32/ovf \
sim:/test_adder32/sum \
sim:/test_adder32/cout \
sim:/test_adder32/sum
run -all
wave zoom full