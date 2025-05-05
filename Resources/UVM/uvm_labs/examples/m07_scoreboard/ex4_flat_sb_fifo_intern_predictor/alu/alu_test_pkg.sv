/***********************************************************************
 * Definitions for the UVM testbench for the ALU scoreboard example
 ***********************************************************************
 * Copyright 2016-2017 Siemens
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

package alu_test_pkg;

   import alu_pkg::*;
   export alu_pkg::*;

   import uvm_pkg::*;
`include "uvm_macros.svh"

`include "alu_config.svh"
`include "alu_txn.svh"
`include "alu_sequence.svh"
`include "alu_driver.svh"
`include "alu_monitor.svh"
`include "alu_agent.svh"
`include "alu_evaluator.svh"
`include "alu_predictor.svh"
`include "alu_scoreboard.svh"
`include "alu_env.svh"
`include "alu_test.svh"

endpackage : alu_test_pkg
