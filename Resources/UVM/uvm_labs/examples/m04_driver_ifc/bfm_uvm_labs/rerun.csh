#!/bin/csh -f
#----------------------------------------------------------------------
# Unix script to run a UVM lab with Questa (no compile/opt)
# Only works in the lab* subdirectories because of relative paths in run.f
#
# Many arguments:
# $1: the name of the UVM test class
# $2 $3 $4 $5 $6 $7: run-time switches such as -gui +FORCE_LOAD_ERROR +NUM_ITEMS=10
#----------------------------------------------------------------------
# Copyright 2023 Siemens
# All Rights Reserved Worldwide
#
# CBS 191212 - Added -suppress 8887
# CBS 181010 - Check *correctly* for work directory
# CBS 180720 - Check for work directory
# CBS 171129 - Rename transcript to lab_test_*.log
# CBS 170714 - Cleanups
#----------------------------------------------------------------------

# Check for UVM test name
if ("x$1" == "x") then
    echo "ERROR: No test name specified, try:"
    echo " $0 lab_test_write6"
    echo
    exit
endif

if (! -d "work") then
    echo "ERROR: No work directory found. Recompile with:"
    echo " ../3step.csh $1"
    echo
    exit
endif

echo "Running simulation with UVM test name $1"

# Simulate the optimized dual-top design
vsim \
	-c -do "run -all" \
	+UVM_TESTNAME=$1 $2 $3 $4 $5 $6 $7 \
	+UVM_NO_RELNOTES -suppress 8887 \
	top_opt

# Rename transcript to log file with test name
mv transcript $1.log
