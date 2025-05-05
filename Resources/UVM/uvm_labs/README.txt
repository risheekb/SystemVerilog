////////////////////////////////////////////////////////////////////////
// Commands for running simulation on labs 2 through 9
// All assume you have are in the lab0* subdirectory
////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////
------------------------------------------------------------------------
Compile, optimize, and run the reset test on the dual-top system
------------------------------------------------------------------------
vlog -f ../run.f
vopt +acc top_hdl top_tb -o top_opt
vsim top_opt -c +UVM_TESTNAME=lab_test_reset -do "run -all; quit"

------------------------------------------------------------------------
Script to compile, optimize, and run the specified test
------------------------------------------------------------------------
../3step.csh lab_test_reset


------------------------------------------------------------------------
Run the reset test in the Questa GUI, assuming you have successfully compiled
	In the GUI type: run -all
------------------------------------------------------------------------
vsim top_opt +UVM_TESTNAME=lab_test_reset


////////////////////////////////////////////////////////////////////////
------------------------------------------------------------------------
Re-run simulation with the write6 test, without recompiling
------------------------------------------------------------------------
vsim top_opt -c +UVM_TESTNAME=lab_test_write6 -do "run -all; quit"

------------------------------------------------------------------------
Script to re-run simulation in BATCH with the write6 test, without recompiling.
------------------------------------------------------------------------
../rerun.csh lab_test_write6

------------------------------------------------------------------------
You can specify up to 6 vsim arguments
------------------------------------------------------------------------
../rerun.csh lab_test_override +NUM_ITEMS=10 +FORCE_LOAD_ERROR


------------------------------------------------------------------------
Script to re-run simulation in GUI with the write6 test, without recompiling.
------------------------------------------------------------------------
../gui.csh lab_test_write6


------------------------------------------------------------------------
NOTES:
The run.f file lists the design and testbench files to be compiled,
plus any Questa compile switches.

The vsim switch -batch runs with no GUI.

The -c switch runs in command line mode, which, combined with -do, is
the same as running batch. Also produces the log file: transcript

------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////
