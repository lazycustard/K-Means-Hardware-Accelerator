onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_distance/x
add wave -noupdate /tb_distance/y
add wave -noupdate /tb_distance/cx
add wave -noupdate /tb_distance/cy
add wave -noupdate /tb_distance/dist
add wave -noupdate /tb_distance/x
add wave -noupdate /tb_distance/y
add wave -noupdate /tb_distance/cx
add wave -noupdate /tb_distance/cy
add wave -noupdate /tb_distance/dist
add wave -noupdate /tb_distance/uut/x
add wave -noupdate /tb_distance/uut/y
add wave -noupdate /tb_distance/uut/cx
add wave -noupdate /tb_distance/uut/cy
add wave -noupdate /tb_distance/uut/dist
add wave -noupdate /tb_distance/uut/dx
add wave -noupdate /tb_distance/uut/dy
add wave -noupdate /tb_distance/x
add wave -noupdate /tb_distance/y
add wave -noupdate /tb_distance/cx
add wave -noupdate /tb_distance/cy
add wave -noupdate /tb_distance/dist
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4086 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 39
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {41 ps}
