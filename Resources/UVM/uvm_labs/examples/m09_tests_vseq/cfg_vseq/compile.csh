#!/bin/csh -f
# Unix script to compile and run the AHB / UVM Configuration example with Questa

set testname=$1
if ("x$1" == "x") set testname="ahb_test_wr_rd"

# Compile
qrun -quiet \
     test_params_pkg.sv \
     ahb/ahb_pkg.sv \
     ahb/ahb_test_pkg.sv \
     ahb/ahb_ifc.sv \
     ahb/ahb_slave_mem.sv \
     top_tb.sv \
     top_hdl.sv \
     +UVM_TESTNAME=$testname $2 $3 $4 \
     +UVM_NO_RELNOTES
