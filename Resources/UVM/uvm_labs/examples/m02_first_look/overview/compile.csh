#/bin/csh -f
# Unix script to compile example from module 2
# Runs in batch, not with the GUI

qrun -quiet \
	-timescale "1ns/1ns" \
	tx_pkg.sv \
	tx_ifc.sv \
	dut.sv \
	top_tb.sv \
	top_hdl.sv \
	$1 $2 $3 $4 \
	+UVM_TESTNAME=tx_test \
