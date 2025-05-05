/***********************************************************************
 * Example UVM Testbench to verify an Instruction Register design.
 *
 * Class: lab_test_write6
 *
 * Defines a UVM test component within the UVM testbench.
 * 1) Extends uvm_test class and constructs the test, config, environment.
 * 2) Runs the write6 sequence.
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

`ifndef lab_test_write6_exists
`define lab_test_write6_exists


class lab_test_write6 extends uvm_test;

  // Register this class name in the factory
  `uvm_component_utils(lab_test_write6)
  function new(string name, uvm_component parent);
    super.new (name, parent);
  endfunction: new

  lab_env env;   // handle to the test environment

  virtual function void build_phase(uvm_phase phase);
    // Create the test environment
    lab_env_config env_cfg;
    lab_tx_agent_config tx_cfg;

    env_cfg = lab_env_config::type_id::create("env_cfg");
    tx_cfg  = lab_tx_agent_config::type_id::create("tx_cfg");

    if (!uvm_config_db #(virtual tx_driver_bfm)::get(this, "", "drv_bfm", tx_cfg.drv_bfm))
      `uvm_fatal(get_type_name(), "No virtual interface 'drv_bfm' found in uvm_config_db")
    if (!uvm_config_db #(virtual tx_monitor_bfm)::get(this, "", "mon_bfm", tx_cfg.mon_bfm))
      `uvm_fatal(get_type_name(), "No virtual interface 'mon_bfm' found in uvm_config_db")

    env_cfg.tx_cfg = tx_cfg;
    tx_cfg.enable_coverage = 1;
    tx_cfg.active = UVM_ACTIVE;
    tx_cfg.monitor_verbosity = UVM_FULL;  // Report debug messages in monitor
    uvm_config_db #(lab_env_config)::set(this, "env", "env_cfg", env_cfg);
    env = lab_env::type_id::create("env", this);
  endfunction: build_phase


  virtual function void end_of_elaboration_phase(uvm_phase phase);
    uvm_top.print_topology();  // prints out the UVM component hierarchy
    // Force monitor to report debug-level messages so that the
    // DUT input and output values are displayed
//////       env.agt.mon.set_report_verbosity_level_hier(UVM_HIGH);
    // A later lab will show how to set a component's verbosity level
    // using configurations instead of a hard coded hierarchy path
  endfunction


  virtual task run_phase(uvm_phase phase);
    // Create and run a sequence
    lab_sequence_write6 seq;

    `uvm_info("TEST", "\n\n\n****** TESTING WRITING TO 6 RANDOM REGISTER LOCATIONS ******\n\n", UVM_NONE)
    phase.phase_done.set_drain_time(this, 10);  // delay objection drop 10ns
    phase.raise_objection(this, get_type_name());
    seq = lab_sequence_write6::type_id::create("seq");
    seq.start(env.agt.sqr);
    phase.drop_objection(this, get_type_name());
  endtask: run_phase

endclass: lab_test_write6
`endif
