#!/bin/csh -f
# Unix script to compile single top example from module 2
# By default, runs in batch
#
# Add the two plusargs to run a million sequence items with objections turned on
#	% compile.csh +items=1000000 +objection

qrun -quiet $1 $2 \
    +define+UVM_REPORT_DISABLE_FILE_LINE \
    tx_pkg.sv tx_ifc.sv instr_reg.sv top_hdl.sv top_tb.sv top.sv \
    +UVM_TESTNAME=tx_test +UVM_NO_RELNOTES
