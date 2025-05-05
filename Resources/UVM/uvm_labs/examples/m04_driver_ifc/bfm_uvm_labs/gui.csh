#!/bin/csh -f
#----------------------------------------------------------------------
# Unix script to run a UVM example, no compilation, and bring up Questa GUI
# One argument: the name of the UVM test class
#----------------------------------------------------------------------
# Copyright 2023 Siemens
# All Rights Reserved Worldwide
#
# CBS 191212 - Added -suppress 8887
# CBS 181010 - Check *correctly* for work directory
# CBS 180720 - Check for work directory
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

echo "Running Questa GUI with UVM test $1 and debug switches: -classdebug -uvmcontrol=all -msgmode both"

# Simulate the optimized dual-top design
vsim \
	-gui -classdebug -uvmcontrol=all -msgmode both \
	+UVM_TESTNAME=$1 $2 $3 $4 $5 $6 $7 \
	+UVM_NO_RELNOTES -suppress 8887 \
	top_opt

# Don't create a filtered log file as GUI sessions may not run to the end
