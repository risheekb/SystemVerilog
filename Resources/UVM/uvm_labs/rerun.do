#----------------------------------------------------------------------
# Questa do file to rerun a UVM lab in vsim (no compile/opt)
# Only works in the lab* subdirectories because of relative paths in run.f
#
# Many arguments:
# $1: the name of the UVM test class
# $2 $3 $4 $5 $6 $7: run-time switches such as -gui +FORCE_LOAD_ERROR +NUM_ITEMS=10
#----------------------------------------------------------------------
# Copyright 2017-2023 Siemens
# All Rights Reserved Worldwide
#
# RJ  170717 - Created
#----------------------------------------------------------------------

quietly set debugop ""
quietly set ipargs ""
quietly set vsimarg ""
quietly set labname ""
quietly set do_args "run -all"

proc macro_help {} {
puts ""
puts "====================================================================="
puts ""
puts "   Rerun Macro help"
puts ""
puts "   Script to compile, optimize and run a UVM lab in GUI mode."
puts ""
puts "   First argument must be the name of the test e.g. lab_test_reset, lab_test_write6 etc."
puts ""
puts "   You can add as many additional arguments as you like e.g. "
puts ""
puts "   +FORCE_LOAD_ERROR +NUM_ITEMS=10"
puts ""
puts "   If one of the additional arguments is classdbg then"
puts ""
puts "   the  -classdebug -uvmcontrol=all -msgmode both switches will be applied to vsim."
puts ""
puts "   and the simulation will only be run to time 0."
puts ""
}

if {$argc == 0} {
	puts ""
    puts "ERROR: No UVM test name specified. "
    puts ""
	macro_help
	abort
}

while {$argc > 0} {
    quietly set iparg $1
    lappend ipargs $iparg
	shift
   }

foreach i $ipargs {
    if {$i == "classdbg"} {
      puts "Running vsim with debug: -classdebug -uvmcontrol=all -msgmode both"
      set debugop "$space -gui -msgmode both -classdebug -uvmcontrol=all"
	  set do_args "onfinish stop; run 0"
     } else {
	  lappend vsimarg $i
	 }
}

quietly set totargs "$vsimarg $debugop"
quietly set labname [lindex $totargs 0]
quietly set simargs [lrange $totargs 1 end]

# Simulate the dual-top design
vsim {*}$simargs +UVM_TESTNAME=$labname  +UVM_NO_RELNOTES -do "$do_args" top_opt
