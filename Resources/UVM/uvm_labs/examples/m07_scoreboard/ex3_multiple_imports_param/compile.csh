#!/bin/csh -f
# Unix script to compile and run with Questa

qrun -quiet \
     alu/alu_pkg.sv alu/alu_test_pkg.sv \
     alu/alu_ifc.sv alu/alu.sv \
     top_tb.sv top_hdl.sv \
     +UVM_TESTNAME=alu_test \
     +UVM_NO_RELNOTES
