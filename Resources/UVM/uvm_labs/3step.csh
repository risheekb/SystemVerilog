#!/bin/csh -f
#----------------------------------------------------------------------
# Script to compile, optimize and run a UVM lab with Questa
# Only works in the lab* subdirectories because of relative paths in run.f
#
# Many arguments:
# $1: the name of the UVM test class
# $2 $3 $4 $5 $6 $7: run-time switches such as -gui +FORCE_LOAD_ERROR +NUM_ITEMS=10
#----------------------------------------------------------------------
# Copyright 2017-2023 Siemens
# All Rights Reserved Worldwide
#
# CBS 200207 - Added support for Visualizer
# CBS 171129 - Rename transcript to lab_test_*.log
# CBS 170714 - Cleanups
#----------------------------------------------------------------------

# Check for UVM test name
if ("x$1" == "x") then
    echo "ERROR: No UVM test name specified, try:"
    echo " $0 lab_test_write6"
    echo 1
    exit
endif

echo "Compiling and running batch with test $1"

# Delete the work library to make sure a compile error prevents vsim from running
rm -rf work

# Compile the SystemVerilog code
vlog -f ../run.f
if ($status != 0) then
    echo "vlog exited with errors, exiting"
    exit 1
endif

# Optimize the dual-top design for debug with both Visualizer and the Classic GUI
vopt top_hdl top_tb -o top_opt \
	 +acc -debug,livesim +designfile # +initmem+0
if ($status != 0) then
    echo "vopt exited with errors, exiting"
    exit 1
endif

# Simulate the optimized dual-top design
vsim +UVM_TESTNAME=$1 $2 $3 $4 $5 $6 $7 +UVM_NO_RELNOTES -c -do "run -all; quit" top_opt

# Rename transcript to log file with test name
mv transcript $1.log
