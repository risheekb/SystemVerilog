/***********************************************************************
 * Example UVM Testbench to verify an Instruction Register design.
 *
 * Class: lab_env
 *
 * Defines the environment portion of the testbench.
 * Creates and configures one or more Agents to stimulate the
 * DUT and creates one or more scoreboards for these agents.
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

`ifndef lab_env_exists
`define lab_env_exists


class lab_env extends uvm_env;

  // Register this class name in the factory
  `uvm_component_utils(lab_env)
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  // Handles to components contained in this environment
  lab_agent      agt;
  lab_scoreboard scb;
  lab_env_config env_cfg;


  virtual function void build_phase(uvm_phase phase);
    agt = lab_agent::type_id::create("agt", this);

    if (!uvm_config_db #(lab_env_config)::get(this, "", "env_cfg", env_cfg))
      `uvm_fatal(get_type_name(), "env_cfg not found in uvm_config_db")

    // Write the agent configuration with a wildcard so it is visibile to sequences too
    uvm_config_db#(lab_tx_agent_config)::set(this, "agt*", "tx_cfg", env_cfg.tx_cfg);

    //
    // LAB 7 ASSIGNMENT, PART 1:
    // Conditionally create the scoreboard if env_cfg.enable_scoreboard is set
    // Assign the return from create() to the handle called "scb" declared above
    //
    //ADD YOUR LAB 7 CODE HERE...
//BEGIN SOLUTION
    if (env_cfg.enable_scoreboard)
      scb = lab_scoreboard::type_id::create("scb", this);
//END SOLUTION



  endfunction: build_phase

  virtual function void connect_phase(uvm_phase phase);
    //
    // LAB 7 ASSIGNMENT, PART 2:
    // If env_cfg.enable_scoreboard is set:
    // - Connect the agent's dut_in_tx_port to the scoreboard.
    // - Connect the agent's dut_out_tx_port to the scoreboard.
    //
    //ADD YOUR LAB 7 CODE HERE...
//BEGIN SOLUTION
    if (env_cfg.enable_scoreboard) begin
      agt.dut_in_tx_port.connect(scb.dut_in_export);
      agt.dut_out_tx_port.connect(scb.dut_out_export);
    end
//END SOLUTION



  endfunction: connect_phase

endclass: lab_env
`endif
