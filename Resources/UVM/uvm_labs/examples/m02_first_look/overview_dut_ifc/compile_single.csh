#!/bin/sh -f
# Unix script to compile single top example from module 2
# By default, runs in batch
#
# Run with the GUI:
#	% compile_single.csh -gui
#
# Run with the Visualizer GUI:
#	% compile_single.csh -gui -visualizer

# Delete old files in case there was a compile error
rm -rf work qrun*

qrun -quiet $1 $2 \
    +define+UVM_REPORT_DISABLE_FILE_LINE \
    tx_pkg.sv tx_ifc.sv instr_reg.sv top_hdl_single.sv top_tb.sv top.sv \
    +UVM_TESTNAME=tx_test +UVM_NO_RELNOTES

echo "**********************************************************************************"
echo "* Expecting: UVM_INFO:10, UVM_WARNING:0, UVM_ERROR:0, UVM_FATAL:0                *"
echo "* Expecting: [SEND] 5                                                            *"
echo "**********************************************************************************"
echo
exit
