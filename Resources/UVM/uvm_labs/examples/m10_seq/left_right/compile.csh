#/bin/csh -f
# Unix script to compile and run example
# Runs in batch, not with the GUI
# Run with gui:
#   % ./compile.csh -gui
# Run with Visualizer
#   % ./compile.csh -gui -visualizer

qrun -quiet \
	-timescale "1ns/1ns" \
	+define+UVM_REPORT_DISABLE_FILE_LINE \
	tx_pkg.sv \
	tx_interface.sv \
	dut.sv \
	top_tb.sv \
	top_hdl.sv \
	$1 $2 $3 $4 \
	+UVM_TESTNAME=tx_test
