/***********************************************************************
 * UVM Testbench to verify an Instruction Register array design.
 *
 * Class: lab_env_config
 *
 * Defines an environment configuration object within the UVM testbench.
 * The class encapsulates various settings affecting other components
 * in the environment.
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

`ifndef lab_env_config_exists
`define lab_env_config_exists


class lab_env_config extends uvm_object;

  // Register this class name in the factory and call super.new
  `uvm_object_utils(lab_env_config)
  function new(string name="lab_env_config");
    super.new(name);
  endfunction

  //
  // LAB 8 ASSIGNMENT:
  // Add the following variables so tests configure the environment
  // 1) A lab_tx_agent_config handle called tx_cfg that holds the agent-level configuration
  // 2) A bit variable called enable_scoreboard to control
  //    whether to create a scoreboard.  Set the default to 1
  //
  //ADD YOUR CODE HERE...
//BEGIN SOLUTION
  lab_tx_agent_config tx_cfg;
  bit enable_scoreboard = 1;
//END SOLUTION



endclass: lab_env_config
`endif
