/***********************************************************************
 * A SystemVerilog testbench for an instruction register.
 * This is the Driver BFM with methods to drive transactions.
 ***********************************************************************
 * Copyright 2023 Siemens
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
 * CBS 191212 - Split off from tx_ifc.sv
 ***********************************************************************/

interface tx_driver_bfm
  import instr_reg_pkg::*;
  (tx_ifc tx_if);

  timeunit 1ns; timeprecision 1ns;

  /////////////////////////////////////////////////////////////////
  // These tasks are called by lab04_driver.svh
  /////////////////////////////////////////////////////////////////

  // Turn a UVM transaction into pin wiggles
  task automatic send(input bit         reset_n,
		      input bit         load_en,
		      input pointer2_t  read_pointer,
		      input pointer2_t  write_pointer,
		      input operand2_t  operand_a,
		      input operand2_t  operand_b,
		      input opcode_t    opcode);
    @(posedge tx_if.clk);
    #1ns;
    tx_if.reset_n       <= reset_n;
    tx_if.load_en       <= load_en;
    tx_if.operand_a     <= operand_a;
    tx_if.operand_b     <= operand_b;
    tx_if.opcode        <= opcode;
    tx_if.write_pointer <= write_pointer;
    tx_if.read_pointer  <= read_pointer;
  endtask

endinterface : tx_driver_bfm
