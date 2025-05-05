/***********************************************************************
 * Definitions for the UVM testbench that connects to the AHB
 * example of configuring a sequence
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


package ahb_test_pkg;

// UVM definitions
  import uvm_pkg::*;
`include "uvm_macros.svh"

// AHB hardware definitions
  import ahb_pkg::*;  export ahb_pkg::*;

// AHB configuration information shared
  import test_params_pkg::*;  export test_params_pkg::*;

// Definitions specific to testbench
  typedef enum int {AHB_NONE=-1, AHB_READ, AHB_WRITE} AHB_OPCODE_T;

// AHB UVM classes
// Sequences
`include "ahb_txn.svh"
`include "ahb_config.svh"
`include "ahb_sequence.svh"
`include "ahb_read_sequence.svh"
`include "ahb_write_sequence.svh"

// Components
`include "ahb_driver.svh"
`include "ahb_monitor.svh"
`include "ahb_agent.svh"
`include "ahb_evaluator.svh"
`include "ahb_predictor.svh"
`include "ahb_scoreboard.svh"
`include "ahb_env.svh"

// Tests
`include "ahb_test.svh"

endpackage : ahb_test_pkg
