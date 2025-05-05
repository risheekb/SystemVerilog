/***********************************************************************
 * A SystemVerilog testbench for an instruction register.
 * This is the Monitor BFM with methods to monitor transactions.
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

interface tx_monitor_bfm
  import instr_reg_pkg::*;
  (tx_ifc tx_if);

  timeunit 1ns; timeprecision 1ns;


  /////////////////////////////////////////////////////////////////
  // These tasks are called by lab05_monitor.svh
  /////////////////////////////////////////////////////////////////

  // Monitor the pins to capture an input transaction
  task automatic get_an_input(output bit         reset_n,
			      output bit         load_en,
			      output pointer2_t  read_pointer,
			      output pointer2_t  write_pointer,
			      output operand2_t  operand_a,
			      output operand2_t  operand_b,
			      output opcode_t    opcode);

    // Capture DUT inputs synchronously
    @(posedge tx_if.clk);
    reset_n       = tx_if.reset_n;
    load_en       = tx_if.load_en;
    read_pointer  = tx_if.read_pointer;
    write_pointer = tx_if.write_pointer;
    operand_a     = tx_if.operand_a;
    operand_b     = tx_if.operand_b;
    opcode        = tx_if.opcode;
  endtask


  // Monitor the pins to capture an output transaction
  // Ignore invalid transactions, ie. entried that are read but were never written
  task automatic get_an_output(output bit         reset_n,
			       output pointer2_t  read_pointer,
			       output instruction_t instruction);

    // Capture DUT outputs synchronously
    // Keep sampling every clock edge until valid data received
    do begin
      @(posedge tx_if.clk);
      #2ns;
      reset_n       = tx_if.reset_n;
      read_pointer  = tx_if.read_pointer;
      instruction   = tx_if.instruction_word;
    end while (tx_if.valid !== '1);
  endtask

endinterface : tx_monitor_bfm
