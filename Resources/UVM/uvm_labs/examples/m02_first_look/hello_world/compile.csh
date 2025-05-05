#!/bin/csh -f

qrun -quiet \
  hello_pkg.sv top.sv \
  +UVM_TESTNAME=hello_test +UVM_NO_RELNOTES
