/***********************************************************************
 * A SystemVerilog testbench for an instruction register
 * Contains the interface to connect the testbench to the design
 * Updated read_pointer to be logic to prevent time 0 race condition
 * Updated to be synthesizable, removing # delays
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
interface tx_ifc
  import instr_reg_pkg::*;  // User-defined types
  import lab_package::*;    // Transaction classes
  (input logic clk);

  timeunit 1ns; timeprecision 1ns;

  // Interface signals
  bit           load_en, reset_n;     // DUT input  - To be written into array
  operand2_t    operand_a, operand_b; // DUT input  - To be written into array
  opcode_t      opcode;               // DUT input  - To be written into array
  instruction_t instruction_word;     // DUT output - Output word read from array
  pointer2_t    write_pointer;        // DUT input  - Index to write to
  pointer2_t    read_pointer;         // DUT output - Index to read from
  logic         valid;                // DUT output - is the output a valid entry

  /////////////////////////////////////////////////////////////////
  // These tasks are called by lab04_driver.svh & lab05_monitor.svh
  /////////////////////////////////////////////////////////////////

  // Turn a UVM transaction into pin wiggles
  task automatic send(lab_tx_in tx_in);
    @(posedge clk);
    reset_n       <= tx_in.reset_n;
    load_en       <= tx_in.load_en;
    operand_a     <= tx_in.operand_a;
    operand_b     <= tx_in.operand_b;
    opcode        <= tx_in.opcode;
    write_pointer <= tx_in.write_pointer;
    read_pointer  <= tx_in.read_pointer;
  endtask


  // Monitor the pins to capture an input transaction
  task automatic get_an_input(lab_tx_in tx_in);
    // Capture DUT inputs synchronously
    @(posedge clk);
    tx_in.reset_n       = reset_n;
    tx_in.load_en       = load_en;
    tx_in.read_pointer  = read_pointer;
    tx_in.write_pointer = write_pointer;
    tx_in.operand_a     = operand_a;
    tx_in.operand_b     = operand_b;
    tx_in.opcode        = opcode;
  endtask


  // Monitor the pins to capture an output transaction
  // Ignore invalid transactions, ie. entried that are read but were never written
  task automatic get_an_output(lab_tx_out tx_out);
    // Capture DUT outputs synchronously
    // Keep sampling every clock edge until valid data received
    do begin
      @(posedge clk);
      tx_out.read_pointer  = read_pointer;
      tx_out.instruction   = instruction_word;
      tx_out.reset_n       = reset_n;
    end while (valid !== 1'b1);
  endtask


  // Wait for reset to deassert, synchronously
  task automatic wait_for_reset();
    @(posedge clk);
    wait (reset_n === 1'b1);
  endtask


  // Wait for N clock cycles, synchronously
  task automatic wait_for_num_clocks(input int unsigned n);
    @(posedge clk);
    repeat (n-1)
      @(posedge clk);
  endtask

endinterface: tx_ifc
