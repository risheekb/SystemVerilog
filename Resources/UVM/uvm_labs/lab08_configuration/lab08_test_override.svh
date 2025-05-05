/***********************************************************************
 * UVM Testbench to verify an Instruction Register array design.
 *
 * Class: lab_test_override
 *
 * Defines a UVM test component within the UVM testbench.
 * 1) Extends uvm_test class and constructs the test environment.
 * 2) Configures the test environment and agent.
 * 3) Overrides the lab_tx_in sequence_item with a
 *    lab_tx_in_override sequence_item
 * 4) Runs the lab_sequence_writeN.
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

`ifndef lab_test_override_exists
`define lab_test_override_exists


class lab_test_override extends uvm_test;

  // Register this class name in the factory
  `uvm_component_utils(lab_test_override)
  function new(string name, uvm_component parent);
    super.new (name, parent);
  endfunction

  lab_env env;                // Handle to the test environment
  lab_env_config env_cfg;     // Handle to a test configuration object
  lab_tx_agent_config tx_cfg; // Handle to agent configuration object


  virtual function void build_phase(uvm_phase phase);
    env_cfg = lab_env_config::type_id::create("env_cfg");
    tx_cfg  = lab_tx_agent_config::type_id::create("tx_cfg");

    env_cfg.tx_cfg = tx_cfg;
    tx_cfg.active            = UVM_ACTIVE;
    tx_cfg.monitor_verbosity = UVM_FULL;  // Report debug messages in monitor

    void'(uvm_config_db#(uvm_bitstream_t)::get(this, "", "count", tx_cfg.count));
    `uvm_info("COUNT", $sformatf("count=%0d.", tx_cfg.count), UVM_LOW)

    tx_cfg.enable_coverage   = 1;
    if (!uvm_config_db #(virtual tx_ifc)::get(this, "", "vif", tx_cfg.vif))
      `uvm_fatal(get_type_name(), "Failed to get virtual interface 'vif' from uvm_config_db")

    uvm_config_db #(lab_env_config)::set(this, "env", "env_cfg", env_cfg);
    //
    // LAB 8 ASSIGNMENT:
    // Add to this build_phase a factory override of the
    // lab_tx_in sequence_item with a lab_tx_in_override sequence_item.
    //
    //ADD YOUR CODE HERE...


    env = lab_env::type_id::create("env", this);
  endfunction: build_phase


  virtual function void end_of_elaboration_phase(uvm_phase phase);
    uvm_factory factory;
    factory = uvm_factory::get();
    factory.print(1);          // Reports components registered in factory
    uvm_top.print_topology();  // Reports the UVM component hierarchy
  endfunction


  virtual task run_phase(uvm_phase phase);
    // Create and run a sequence
    lab_sequence_writeN seq;

    phase.phase_done.set_drain_time(this, 10);  // Delay objection drop 10ns
    phase.raise_objection(this, get_type_name());
    `uvm_info("TEST_OVERRIDE", "\n\n\n****** TEST CONFIG, FACTORY OVERRIDE, AND WRITING TO N RANDOM REGISTER LOCATIONS ******\n\n", UVM_NONE)
    seq = lab_sequence_writeN::type_id::create("seq");
    seq.init_start(env.agt.sqr, tx_cfg);
    phase.drop_objection(this, get_type_name());
  endtask: run_phase

endclass: lab_test_override
`endif
