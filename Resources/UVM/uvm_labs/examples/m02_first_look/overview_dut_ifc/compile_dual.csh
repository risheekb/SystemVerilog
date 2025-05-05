#!/bin/csh -f
# Unix script to compile dual-top example from module 2
# By default, runs in batch
#
# Run with the GUI:
#	% compile_dual.csh -gui
#
# Run with the Visualizer GUI:
#	% compile_dual.csh -gui -visualizer


qrun -quiet $1 $2 \
    +define+UVM_REPORT_DISABLE_FILE_LINE \
    tx_pkg.sv tx_ifc.sv instr_reg.sv top_hdl_dual.sv top_tb.sv \
    +UVM_TESTNAME=tx_test +UVM_NO_RELNOTES
