#!/bin/csh -f
#----------------------------------------------------------------------
# Unix script to run a UVM example, no compilation, and bring up Questa GUI
# One argument: the name of the UVM test class
#----------------------------------------------------------------------
# Copyright 2020-2023 Siemens
# All Rights Reserved Worldwide
#
# CBS 200206 Created
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

set VIS_SWITCH = -qwavedb=+class=../uvmclassfilter.txt+signal+transaction+memory=10000,2

echo "Running Questa Visualizer with +UVM_TESTNAME=$1 ${VIS_SWITCH}"

# Simulate the optimized dual-top design
vsim \
	-visualizer \
	${VIS_SWITCH} \
	+UVM_TESTNAME=$1 $2 $3 $4 $5 $6 $7 +UVM_NO_RELNOTES \
	top_opt
