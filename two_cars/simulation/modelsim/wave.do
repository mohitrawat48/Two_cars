onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/Clk
add wave -noupdate /testbench/Reset
add wave -noupdate /testbench/car1_pos_max
add wave -noupdate /testbench/car2_pos_max
add wave -noupdate /testbench/car3_pos_max
add wave -noupdate /testbench/car1_pos
add wave -noupdate /testbench/car2_pos
add wave -noupdate /testbench/car3_pos
add wave -noupdate /testbench/yellowcar1_Y_Min
add wave -noupdate /testbench/yellowcar2_Y_Min
add wave -noupdate /testbench/yellowcar3_Y_Min
add wave -noupdate /testbench/keycode_s1
add wave -noupdate /testbench/keycode_s2
add wave -noupdate /testbench/keycode_s3
add wave -noupdate /testbench/my_test/my_lane/State
add wave -noupdate /testbench/my_test/my_lane/random_num
add wave -noupdate -radix hexadecimal /testbench/my_test/my_lane/counter
add wave -noupdate -radix hexadecimal /testbench/my_test/my_lane/counter_in
add wave -noupdate -radix hexadecimal /testbench/my_test/my_lane/limit
add wave -noupdate -radix hexadecimal /testbench/my_test/my_lane/limit_in
add wave -noupdate -radix hexadecimal /testbench/my_test/my_lane/counter_limit
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {243845 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 288
configure wave -valuecolwidth 131
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {97075 ps}
