/***********************************************************************
 * UVM Testbench to verify an Instruction Register array design.
 *
 * Class: lab_test_vseq
 *
 * Defines a UVM test component within the UVM testbench.
 * 1) Constructs and configures a specific test environment with the
 *    environment's agent, scoreboard, etc.
 * 2) Runs a virtual sequence that in turn starts two sequences in
 *    series: the reset sequence, and then the write6 sequence.
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

`ifndef lab_test_vseq_exists
`define lab_test_vseq_exists


class lab_test_vseq extends lab_test_base;

  // Register this class name in the factory
  `uvm_component_utils(lab_test_vseq)
  function new(string name, uvm_component parent);
    super.new (name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    //
    // LAB 9 ASSIGNMENT, PART 1:
    // Move the config code to the base test
    // 1) Add a call to super.build_phase(phase) method
    // 2) Cut the config and env code from this file
    //    and paste in to lab09_test_base::build_phase()
    //
  //ADD YOUR CODE HERE...
//BEGIN SOLUTION
    super.build_phase(phase);

/*
//END SOLUTION


    env_cfg = lab_env_config::type_id::create("env_cfg");
    env_cfg.enable_scoreboard = 1;
    tx_cfg = lab_tx_agent_config::type_id::create("tx_cfg");
    tx_cfg.active            = UVM_ACTIVE;
    tx_cfg.monitor_verbosity = UVM_FULL;  // Report debug messages in monitor
    tx_cfg.enable_coverage   = 1;
    env_cfg.tx_cfg = tx_cfg;

    if (!uvm_config_db #(virtual tx_ifc)::get(this, "", "vif", tx_cfg.vif))
      `uvm_fatal(get_type_name(), "Failed to get virtual interface 'vif' in uvm_config_db")

    uvm_config_db #(lab_env_config)::set(this, "env", "env_cfg", env_cfg);

    env = lab_env::type_id::create("env", this);

  //ADD YOUR CODE HERE...
//BEGIN SOLUTION
*/
//END SOLUTION


  endfunction: build_phase



  //
  // LAB 9 ASSIGNMENT, PART 2:
  // Define a run_phase() that:
  // 1) Declares a lab_virtual_sequence handle and creates an object
  // 2) Call super.run_phase()
  // 3) Raises an objection flag
  // 4) Calls the virtual sequence's init_start with the agent config object
  // 5) Drops the objection flag after the virtual sequence completes
  //
  //ADD YOUR CODE HERE...
//BEGIN SOLUTION
  virtual task run_phase(uvm_phase phase);
    lab_virtual_sequence vseq;

    super.run_phase(phase);

    `uvm_info("TEST_VSEQ", "\n\n\n****** TEST VIRTUAL SEQUENCE ******\n\n", UVM_NONE)
    vseq = lab_virtual_sequence::type_id::create("vseq");

    phase.raise_objection(this, "test objects to run_phase ending");
    vseq.init_start(tx_cfg);
    phase.drop_objection(this, "test drops objection to run_phase ending");

  endtask: run_phase
//END SOLUTION


endclass: lab_test_vseq

`endif
