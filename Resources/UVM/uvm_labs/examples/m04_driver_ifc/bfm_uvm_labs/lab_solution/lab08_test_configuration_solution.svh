/***********************************************************************
 * Example UVM Testbench to verify an Instruction Register design.
 *
 * Class: lab_test_configuration
 *
 * Defines a UVM test component within the UVM testbench.
 * 1) Extends uvm_test class and constructs the test environment.
 * 2) Configures the test environment and agent, fetching the number of
 *    sequence items from the command line switch:
 *     +uvm_set_config_int=uvm_test_top,nitems,10
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
 *
 * CBS 191212 - Switched to drv_bfm, mon_bfm
 **********************************************************************/

`ifndef lab_test_configuration_exists
`define lab_test_configuration_exists


class lab_test_configuration extends uvm_test;

  // Register this class name in the factory
  `uvm_component_utils(lab_test_configuration)
  function new(string name, uvm_component parent);
    super.new (name, parent);
  endfunction: new


  lab_env env;                // Handle to the test environment
  lab_env_config env_cfg;     // Handle to a test configuration object
  lab_tx_agent_config tx_cfg; // Handle to agent configuration object

  virtual function void build_phase(uvm_phase phase);
    //
    // LAB 8 ASSIGNMENT, PART 1:
    // Construct and configure this specific test.
    // 1. Create two configuration objects
    //    - Create a lab_env_config configuration object.
    //      A handle called "env_cfg" has already been declared above.
    //    - Create a lab_tx_agent_config object with the tx_cfg handle declared above.
    //      Store a copy of this handle in env_cfg.tx_cfg
    // 2. Set the configuration control variables for the tx agent as follows:
    //    - tx_cfg.active = UVM_ACTIVE
    //    - tx_cfg.monitor_verbosity = UVM_FULL
    //    - tx_cfg.enable_coverage = 1
    //    - tx_cfg.nitems - Get this optional value from the uvm_config_db at the
    //        uvm_test_top level, and print a confirmation message.
    //        (What is the type of the value in the uvm_config_db?)
    //    - tx_cfg.drv_bfm & mon_bfm - Get these values from the uvm_config_db:
    //        location this, empty path name, name "drv_bfm" & "mon_bfm"
    // 3. Store a handle to the environment configuration object in the configuration
    //    data base, with an instance name of "env" and "env_cfg" as the field name
    // 4. Construct a lab_env environment object. The handle "env" is declared above.
    //
    //ADD YOUR CODE HERE...
//BEGIN SOLUTION
    // set up the configuration for this test
    env_cfg = lab_env_config::type_id::create("env_cfg");
    tx_cfg = lab_tx_agent_config::type_id::create("tx_cfg");
    env_cfg.tx_cfg = tx_cfg;

    tx_cfg.active = UVM_ACTIVE;
    tx_cfg.monitor_verbosity = UVM_FULL;  // Report debug messages in monitor
//    tx_cfg.monitor_verbosity = UVM_NONE; // See if turning off monitor debug messages works
    tx_cfg.enable_coverage = 1;

    // Read the (optional) number of items from the command line
    void'(uvm_config_db#(uvm_bitstream_t)::get(this, "", "nitems", tx_cfg.nitems));
    `uvm_info(get_type_name(), $sformatf("nitems=%0d.", tx_cfg.nitems), UVM_LOW)

    if (!uvm_config_db #(virtual tx_driver_bfm)::get(this, "", "drv_bfm", tx_cfg.drv_bfm))
      `uvm_fatal(get_type_name(), "No virtual interface 'drv_bfm' found in uvm_config_db")
    if (!uvm_config_db #(virtual tx_monitor_bfm)::get(this, "", "mon_bfm", tx_cfg.mon_bfm))
      `uvm_fatal(get_type_name(), "No virtual interface 'mon_bfm' found in uvm_config_db")

    // Store the env_cfg handle in the UVM configuration database
    uvm_config_db #(lab_env_config)::set(this, "env", "env_cfg", env_cfg);

    // Construct the environment
    env = lab_env::type_id::create("env", this);
//END SOLUTION



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
  endfunction: end_of_elaboration_phase



  // Run phase to execute the writeN sequence
  virtual task run_phase(uvm_phase phase);
    lab_sequence_writeN seq;

    phase.phase_done.set_drain_time(this, 10);  // delay objection drop 10ns
    phase.raise_objection(this, get_full_name());
    `uvm_info("TEST", "\n\n\n****** TESTING WRITING TO N RANDOM REGISTER LOCATIONS ******\n\n", UVM_NONE)
    //
    // LAB 8 ASSIGNMENT, PART 2:
    // Create and call init_start(...) for the lab_sequence_writeN
    //
    //ADD YOUR CODE HERE...
//BEGIN SOLUTION
    seq = lab_sequence_writeN::type_id::create("seq");
    seq.init_start(env.agt.sqr, tx_cfg);
//END SOLUTION

    phase.drop_objection(this, get_full_name());
  endtask: run_phase

endclass: lab_test_configuration
`endif
