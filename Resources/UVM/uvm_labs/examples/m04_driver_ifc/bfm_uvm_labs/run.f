////////////////////////////////////////////////////////////////////////
// Questa command file with the files to be compiled for the UVM labs.
//
// It expected that simulation is run from one of the lab
// subdirectories (e.g.: lab02_complete_tb, lab03_transactions, etc.).
// The "../" in each file path below only works when simulation is
// invoked from one of these lab subdirectories.
////////////////////////////////////////////////////////////////////////
// Copyright 2017-2023 Siemens
// All Rights Reserved Worldwide
//
// CBS 230316 - Changed tb_* to tx_*
// CBS 191212 - Add tb_driver_bfm and tb_monitor_bfm
// CBS 170714 - Cleanups
////////////////////////////////////////////////////////////////////////

//
// Error Injection Option at run-time
//
//+FORCE_LOAD_ERROR

//
// DUT Source Files
//
../lab_dut/instr_reg_pkg.sv
../lab_dut/instr_reg.sv

//
// UVM Testbench Source Files
//
../lab_testbench/lab_package.sv
../lab_testbench/top_hdl.sv
../lab_testbench/top_tb.sv
../lab_testbench/tx_ifc.sv
../lab_testbench/tx_driver_bfm.sv
../lab_testbench/tx_monitor_bfm.sv

//
// UVM run-time command-line options
//

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
