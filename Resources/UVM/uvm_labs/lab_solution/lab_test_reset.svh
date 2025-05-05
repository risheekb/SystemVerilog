/***********************************************************************
 * UVM Testbench to verify an Instruction Register array design.
 *
 * Class: lab_test_reset
 *
 * Contains the base class definition for the test portion of the UVM
 * testbench.
 ***********************************************************************
 * Copyright 2016-2023 Siemens
 * All Rights Reserved Worldwide
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *       http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
 * implied.  See the License for the specific language governing
 * permissions and limitations under the License.
 **********************************************************************/

`ifndef lab_test_reset_exists
`define lab_test_reset_exists


class lab_test_reset extends uvm_test;

  // Register this class name in the factory
  `uvm_component_utils(lab_test_reset)
  function new(string name, uvm_component parent);
    super.new (name, parent);
  endfunction


  lab_env env;   // handle to the test environment

  virtual function void build_phase(uvm_phase phase);
    // Create the test environment
    lab_env_config env_cfg;
    lab_tx_agent_config tx_cfg;

    env_cfg = lab_env_config::type_id::create("env_cfg");
    tx_cfg  = lab_tx_agent_config::type_id::create("tx_cfg");
    env_cfg.tx_cfg = tx_cfg;
    tx_cfg.active            = UVM_ACTIVE;
    tx_cfg.monitor_verbosity = UVM_FULL;  // Report debug messages in monitor
    tx_cfg.enable_coverage   = 0;
    if (!uvm_config_db #(virtual tx_ifc)::get(this, "", "vif", tx_cfg.vif))
      `uvm_fatal(get_type_name(), "No virtual interface 'vif' found in uvm_config_db")
    uvm_config_db #(lab_env_config)::set(this, "env", "env_cfg", env_cfg);
    env = lab_env::type_id::create("env", this);
  endfunction: build_phase


  virtual function void end_of_elaboration_phase(uvm_phase phase);
    uvm_top.print_topology();  // prints out the UVM component hierarchy
    // Force monitor to report debug-level messages so that the
    // DUT input and output values are displayed
//       env.agt.mon.set_report_verbosity_level_hier(UVM_HIGH);
    // A later lab will show how to set a component's verbosity level
    // using configurations instead of a hard coded hierarchy path
  endfunction


  virtual task run_phase(uvm_phase phase);
    // Create and run a sequence
    lab_sequence_reset seq;

    `uvm_info("TEST_RESET", "\n\n\n****** TEST RESET ******\n\n",UVM_NONE)

    phase.raise_objection(this, get_type_name());
    phase.phase_done.set_drain_time(this, 10);  // delay objection drop 10ns
    seq = lab_sequence_reset::type_id::create("seq");
    seq.start(env.agt.sqr);
      // The sequence start method does three things:
      // 1) associates the sequence with a sequencer
      // 2) starts the sequence body method
      // 3) blocks until the sequence body method exits
    phase.drop_objection(this, get_type_name());
  endtask: run_phase

endclass: lab_test_reset
`endif
