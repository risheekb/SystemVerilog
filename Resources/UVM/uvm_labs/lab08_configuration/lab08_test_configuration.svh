/***********************************************************************
 * UVM Testbench to verify an Instruction Register array design.
 *
 * Class: lab_test_configuration
 *
 * Defines a UVM test component within the UVM testbench.
 * 1) Extends uvm_test class and constructs the test environment.
 * 2) Configures the test environment and agent, fetching the number of
 *    sequence items from the command line switch:
 *     +uvm_set_config_int=uvm_test_top,count,10
 * 3) Runs the lab_sequence_writeN.
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

`ifndef lab_test_configuration_exists
`define lab_test_configuration_exists


class lab_test_configuration extends uvm_test;

  // Register this class name in the factory
  `uvm_component_utils(lab_test_configuration)
  function new(string name, uvm_component parent);
    super.new (name, parent);
  endfunction


  lab_env env;                // Handle to the test environment
  lab_env_config env_cfg;     // Handle to a test configuration object
  lab_tx_agent_config tx_cfg; // Handle to agent configuration object

  virtual function void build_phase(uvm_phase phase);
    //
    // LAB 8 ASSIGNMENT, PART 1:
    // Construct and configure this specific test.
    // 1. Create two configuration objects
    //    - Create a lab_env_config configuration object.
    //      A handle called env_cfg has already been declared above.
    //    - Create a lab_tx_agent_config object with the tx_cfg handle declared above.
    //      Store a copy of this handle in env_cfg.tx_cfg
    // 2. Set the configuration control variables for the tx agent as follows:
    //    - tx_cfg.active = UVM_ACTIVE
    //    - tx_cfg.monitor_verbosity = UVM_FULL
    //    - tx_cfg.enable_coverage = 1
    //    - tx_cfg.count - Get this optional value from the uvm_config_db at the
    //        test scope, and print a confirmation message.
    //        (What is the type of the value in the uvm_config_db?)
    //    - tx_cfg.vif - Get this virtual tx_ifc value from the uvm_config_db:
    //        location this, empty path name, name "vif"
    // 3. Store a handle to the environment configuration object in the configuration
    //    data base, with an instance name of "env" and "env_cfg" as the field name
    // 4. Construct a lab_env environment object. The handle env is declared above.
    //
    //ADD YOUR CODE HERE...

  endfunction: build_phase


  virtual function void end_of_elaboration_phase(uvm_phase phase);
    uvm_factory factory;
    factory = uvm_factory::get();

   `uvm_info("PRINT", "factory.print(1);", UVM_LOW)
    factory.print(1);

   `uvm_info("PRINT", "uvm_top.print_topology();", UVM_LOW)
    uvm_top.print_topology();  // prints out the UVM component hierarchy

   `uvm_info("PRINT", "print_config();", UVM_LOW)
    print_config();
  endfunction



  // Run phase to execute the writeN sequence
  virtual task run_phase(uvm_phase phase);
    lab_sequence_writeN seq;

    phase.phase_done.set_drain_time(this, 10);  // delay objection drop 10ns
    phase.raise_objection(this, get_type_name());
    `uvm_info("TEST_CONFIG", "\n\n\n****** TEST CONFIG AND WRITING TO N RANDOM REGISTER LOCATIONS ******\n\n", UVM_NONE)
    //
    // LAB 8 ASSIGNMENT, PART 2:
    // Create the lab_sequence_writeN object and call init_start(...)
    //
    //ADD YOUR CODE HERE...

    phase.drop_objection(this, get_type_name());
  endtask: run_phase

endclass: lab_test_configuration
`endif
