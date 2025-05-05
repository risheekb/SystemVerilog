/***********************************************************************
 * UVM Testbench to verify an Instruction Register array design.
 *
 * Class: lab_test_base
 *
 * Defines a UVM test component within the UVM testbench.
 * 1) Constructs and configures a specific test environment with the
 *    environment's agent, scoreboard, etc.
 * 2) Create & initialize config objects and store in the uvm_config_db
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

`ifndef lab_test_base_exists
`define lab_test_base_exists


class lab_test_base extends uvm_test;

  // Register this class name in the factory
  `uvm_component_utils(lab_test_base)
  function new(string name, uvm_component parent);
    super.new (name, parent);
  endfunction

  lab_env env;                // Handle to the test environment
  lab_env_config env_cfg;     // Environment configuration object
  lab_tx_agent_config tx_cfg; // Agentconfiguration object

  virtual function void build_phase(uvm_phase phase);
    //
    // LAB 9 ASSIGNMENT, PART 1:
    // Move the common build_phase code into this base test
    // 1) Copy the config and env-create code from lab_test_vseq
    //    build_phase() into this method
    //
  //ADD YOUR CODE HERE...
//BEGIN SOLUTION
    env_cfg = lab_env_config::type_id::create("env_cfg");
    env_cfg.enable_scoreboard = 1;
    tx_cfg = lab_tx_agent_config::type_id::create("tx_cfg");
    env_cfg.tx_cfg = tx_cfg;
    tx_cfg.active            = UVM_ACTIVE;
    tx_cfg.monitor_verbosity = UVM_FULL;  // Report debug messages in monitor
    tx_cfg.enable_coverage   = 1;

    if (!uvm_config_db #(virtual tx_ifc)::get(this, "", "vif", tx_cfg.vif))
      `uvm_fatal(get_type_name(), "Failed to get virtual interface 'vif' in uvm_config_db")

    uvm_config_db #(lab_env_config)::set(this, "env", "env_cfg", env_cfg);

    env = lab_env::type_id::create("env", this);
//END SOLUTION


  endfunction: build_phase


  virtual function void end_of_elaboration_phase(uvm_phase phase);
    uvm_top.print_topology();  // prints out the UVM component hierarchy
  endfunction


  // The base test sets the drain time in the run phase
  virtual task run_phase(uvm_phase phase);
    phase.phase_done.set_drain_time(this, 10);  // delay objection drop 10ns
  endtask


endclass: lab_test_base

`endif
