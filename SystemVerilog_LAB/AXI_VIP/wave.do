onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top/dut/aclk
add wave -noupdate /top/dut/arst
add wave -noupdate -expand -group W_ADDR_CH /top/dut/awid
add wave -noupdate -expand -group W_ADDR_CH /top/dut/awaddr
add wave -noupdate -expand -group W_ADDR_CH /top/dut/awlen
add wave -noupdate -expand -group W_ADDR_CH /top/dut/awsize
add wave -noupdate -expand -group W_ADDR_CH /top/dut/awburst
add wave -noupdate -expand -group W_ADDR_CH /top/dut/awlock
add wave -noupdate -expand -group W_ADDR_CH /top/dut/awcache
add wave -noupdate -expand -group W_ADDR_CH /top/dut/awprot
add wave -noupdate -expand -group W_ADDR_CH /top/dut/awvalid
add wave -noupdate -expand -group W_ADDR_CH /top/dut/awready
add wave -noupdate -expand -group W_DATA_CH /top/dut/wid
add wave -noupdate -expand -group W_DATA_CH /top/dut/wdata
add wave -noupdate -expand -group W_DATA_CH /top/dut/wstrb
add wave -noupdate -expand -group W_DATA_CH /top/dut/wlast
add wave -noupdate -expand -group W_DATA_CH /top/dut/wuser
add wave -noupdate -expand -group W_DATA_CH /top/dut/wvalid
add wave -noupdate -expand -group W_DATA_CH /top/dut/wready
add wave -noupdate -expand -group W_RESP_CH /top/dut/bid
add wave -noupdate -expand -group W_RESP_CH /top/dut/bresp
add wave -noupdate -expand -group W_RESP_CH /top/dut/buser
add wave -noupdate -expand -group W_RESP_CH /top/dut/bvalid
add wave -noupdate -expand -group W_RESP_CH /top/dut/bready
add wave -noupdate -group R_ADDR_CH /top/dut/arid
add wave -noupdate -group R_ADDR_CH /top/dut/araddr
add wave -noupdate -group R_ADDR_CH /top/dut/arlen
add wave -noupdate -group R_ADDR_CH /top/dut/arsize
add wave -noupdate -group R_ADDR_CH /top/dut/arburst
add wave -noupdate -group R_ADDR_CH /top/dut/arlock
add wave -noupdate -group R_ADDR_CH /top/dut/arcache
add wave -noupdate -group R_ADDR_CH /top/dut/arprot
add wave -noupdate -group R_ADDR_CH /top/dut/arvalid
add wave -noupdate -group R_ADDR_CH /top/dut/arready
add wave -noupdate -group R_DATA_CH /top/dut/rid
add wave -noupdate -group R_DATA_CH /top/dut/rdata
add wave -noupdate -group R_DATA_CH /top/dut/rlast
add wave -noupdate -group R_DATA_CH /top/dut/ruser
add wave -noupdate -group R_DATA_CH /top/dut/rvalid
add wave -noupdate -group R_DATA_CH /top/dut/rready
add wave -noupdate -group R_DATA_CH /top/dut/rresp
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {72 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ns} {1050 ns}
