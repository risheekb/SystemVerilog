////////////////////////////////////////////////////////////////////////
// Questa vlog commands & SystemVerilog files for the UVM labs.
//
// It expected that simulation will be run from one of the lab
// subdirectories (e.g.: lab02_complete_tb, lab03_transactions, etc.).
// The "../" in each file path below only works when simulation is
// invoked from one of these lab subdirectories.
////////////////////////////////////////////////////////////////////////
// Copyright 2017-2023 Siemens
// All Rights Reserved Worldwide
//
// CBS 200207 Add -lint to find more TB bugs
// CBS 170714 Cleanups
////////////////////////////////////////////////////////////////////////

//
// Error Injection Option at run-time
//+FORCE_LOAD_ERROR

//
// Questa compile switch for extra checking at both compile and run-time.
// Suppress message about specialization
-lint -suppress 2181,2286

//
// DUT Source Files
../lab_dut/instr_reg_pkg.sv
../lab_dut/instr_reg.sv

//
// UVM Testbench Source Files
../lab_testbench/lab_package.sv
../lab_testbench/top_hdl.sv
../lab_testbench/top_tb.sv
../lab_testbench/tx_ifc.sv

//
// UVM run-time command-line options

//+UVM_TESTNAME=lab_test_reset
//+UVM_TESTNAME=lab_test_write6
//+UVM_TESTNAME=lab_test_run_all
//+UVM_TESTNAME=lab_test_vseq
//+UVM_TESTNAME=lab_test_configuration +NUM_ITEMS=10
//+UVM_TESTNAME=lab_test_override      +NUM_ITEMS=10
//+UVM_TESTNAME=lab_reg_backdoor_test

//+UVM_VERBOSITY=UVM_LOW
//+UVM_VERBOSITY=UVM_MEDIUM
//+UVM_VERBOSITY=UVM_HIGH
