#!/bin/csh -f
# Unix script to compile UVM report example from module 2, Supplemental Information
# Runs in batch, not with the GUI

echo
echo
echo "------------------------------------------------------------------"
echo "******** This test generates errors"
echo "------------------------------------------------------------------"

qrun -quiet \
	report_action.sv \
	+UVM_TESTNAME=report_action_test \
	+UVM_NO_RELNOTES

echo "------------------------------------------------------------------"
echo "******** The above test generates errors"
echo "------------------------------------------------------------------"
echo
