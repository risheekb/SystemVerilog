/***********************************************************************
 * Example UVM Testbench to verify an Instruction Register design.
 *
 * Package: lab_package
 *
 * Encapsulates all of the classes that make up the UVM testbench.
 * Each class is defined in a separate file, and inserted into this
 * package using a `include compiler directive.
 **********************************************************************/

package lab_package;
  timeunit 1ns; timeprecision 1ns;

  //
  // include and import the standard UVM library
  //
  `include "uvm_macros.svh"
  import uvm_pkg::*;

  // user-defined types are defined in instr_reg_pkg.sv
  import instr_reg_pkg::*;

  //
  // NOTE! SystemVerilog requires that class names be defined before
  // being referenced, which means the files containing the classes must
  // be compiled in a specific order.  typedef definitions can be used
  // to "forward declare" class names, which allows the actual classes
  // to be compiled in any order. The only order dependency is that the
  // file containing the typedef definitions must be compiled first.
  //
  typedef class lab_tx_base;
  typedef class lab_tx_in;
  typedef class lab_tx_out;
  typedef class lab_tx_in_override;
  typedef class lab_sequence_reset;
  typedef class lab_sequence_write6;
  typedef class lab_sequence_writeN;
  typedef class lab_virtual_sequence;
  typedef class lab_driver;
  typedef class lab_monitor;
  typedef class lab_agent;
  typedef class lab_coverage_collector;
  typedef class lab_env;
  typedef class lab_scoreboard;
  typedef class lab_test_vseq;
  typedef class lab_test_reset;
  typedef class lab_test_write6;
  typedef class lab_env_config;
  typedef class lab_tx_agent_config;
  typedef class lab_test_configuration;
  typedef class lab_test_override;

  //
  // UVM components to completed as part of the workshop labs.
  //
  // IMPORTANT!!!  Each `include line must be uncommented as that
  // lab file is completed, so that your version is used instead of
  // the solution files below.
  //

//  `include "../lab03_transactions/lab03_tx_base.svh"
//  `include "../lab03_transactions/lab03_tx_in.svh"
//  `include "../lab03_transactions/lab03_tx_out.svh"
//  `include "../lab03_transactions/lab03_sequence_reset.svh"
//  `include "../lab03_transactions/lab03_sequence_write6.svh"

//  `include "../lab04_sequencer_driver/lab04_driver.svh"

//  `include "../lab05_monitor_agent/lab05_monitor.svh"
//  `include "../lab05_monitor_agent/lab05_agent.svh"

//  `include "../lab06_coverage/lab06_coverage.svh"

//  `include "../lab07_scoreboard_env/lab07_scoreboard.svh"
//  `include "../lab07_scoreboard_env/lab07_environment.svh"

//  `include "../lab08_configuration/lab08_tx_agent_config.svh"
//  `include "../lab08_configuration/lab08_env_config.svh"
//  `include "../lab08_configuration/lab08_sequence_writeN.svh"
//  `include "../lab08_configuration/lab08_test_configuration.svh"
//  `include "../lab08_configuration/lab08_test_override.svh"

//  `include "../lab09_test_vseq/lab09_test_base.svh"
//  `include "../lab09_test_vseq/lab09_test_vseq.svh"
//  `include "../lab09_test_vseq/lab09_virtual_sequence.svh"

  //
  // Completed versions of each component. These files provide the rest
  // of the complete UVM testbench so that the UVM blocks completed in
  // each lab can be tested.
  // (NOTE: You do not need to comment out these lines. If your version
  // of a class has already been included, the solution version will be
  // ignored.
  //
  `include "../lab_solution/lab03_tx_base_solution.svh"
  `include "../lab_solution/lab03_tx_in_solution.svh"
  `include "../lab_solution/lab03_tx_out_solution.svh"
  `include "../lab_solution/lab03_sequence_reset_solution.svh"
  `include "../lab_solution/lab03_sequence_write6_solution.svh"

  `include "../lab_solution/lab04_driver_solution.svh"

  `include "../lab_solution/lab05_monitor_solution.svh"
  `include "../lab_solution/lab05_agent_solution.svh"

  `include "../lab_solution/lab06_coverage_solution.svh"

  `include "../lab_solution/lab07_scoreboard_solution.svh"
  `include "../lab_solution/lab07_environment_solution.svh"

  `include "../lab_solution/lab08_tx_agent_config_solution.svh"
  `include "../lab_solution/lab08_env_config_solution.svh"
  `include "../lab_solution/lab08_sequence_writeN_solution.svh"
  `include "../lab_solution/lab08_test_configuration_solution.svh"
  `include "../lab_solution/lab08_test_override_solution.svh"

  `include "../lab_solution/lab09_test_base_solution.svh"
  `include "../lab_solution/lab09_test_vseq_solution.svh"
  `include "../lab_solution/lab09_virtual_sequence_solution.svh"

  //
  // Additional UVM components that are not rewritten in any of the labs
  //
  `include "../lab_solution/lab_test_reset.svh"
  `include "../lab_solution/lab_test_write6.svh"
  `include "../lab_solution/lab08_tx_in_override_solution.svh"

endpackage: lab_package
