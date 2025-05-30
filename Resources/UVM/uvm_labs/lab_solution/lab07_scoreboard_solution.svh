/***********************************************************************
 * UVM Testbench to verify an Instruction Register array design.
 *
 * Class: lab_scoreboard
 *
 * Defines a scoreboard component class within the UVM testbench.
 * Receives expected results transactions from a predictor and actual
 * DUT output transactions from a monitor.  Expected results are
 * saved in an associative array, and then compared to actual outputs
 * when the actual outputs are broadcast from the monitor.
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

`ifndef lab_scoreboard_exists
 `define lab_scoreboard_exists


//
// LAB 7 ASSIGNMENT, PART 1:
// Add the macros to define two uniquified analysis imp exports, with
// the suffixes "_dut_in" and "_dut_out".
//
//ADD YOUR CODE HERE...
//BEGIN SOLUTION
`uvm_analysis_imp_decl(_dut_in)
`uvm_analysis_imp_decl(_dut_out)
//END SOLUTION


class lab_scoreboard extends uvm_scoreboard;

  // Register this class name in the factory
  `uvm_component_utils(lab_scoreboard)
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  // Handles for the two uniquified analysis imp exports
  uvm_analysis_imp_dut_in  #(lab_tx_in,  lab_scoreboard) dut_in_export;
  uvm_analysis_imp_dut_out #(lab_tx_out, lab_scoreboard) dut_out_export;

  // Scorecard to keep track of transactions that passed or failed
  int match, mismatch;

  //
  // LAB 7 ASSIGNMENT, PART 2:
  // Add an associative array expect_a of lab_tx_out handles
  // indexed by pointer2_t type
  //
  //ADD YOUR CODE HERE...
  //BEGIN SOLUTION
  lab_tx_out expect_a[pointer2_t];  // associative array
  //END SOLUTION


  virtual function void build_phase(uvm_phase phase);
    // Construct the two imp exports (don't need the factory for this)
    dut_in_export  = new("dut_in_export", this);
    dut_out_export = new("dut_out_export", this);
  endfunction

  //
  // LAB 7 ASSIGNMENT, PART 3:
  // Add the code to implement the write() method for the _dut_in imp export.
  // REMEMBER, the write() name has been uniquified to be "write_dut_in()".
  // The names below refer to properties in lab_tx_base, lab_tx_out & lab_tx_in
  // This method should:
  // 1) If reset_n is asserted in the input transaction, delete the contents
  //    of expect_a array as the design has been reset.
  // 2) Else, if load_en is asserted, create a transaction with the expected values.
  //    The input transaction has properties opcode, operand_a and operand_b,
  //    while the output transaction has a struct instruction with opc, op_a, and op_b
  //    a) Declare a handle exp of type lab_tx_out, to hold the expected transaction
  //    b) Create a lab_tx_out object to hold the expected values
  //    c) Copy t.opcode, operand_a and operand_b inputs to exp.instruction.opc, op_a, and op_b
  //             exp.instruction.opc = t.opcode;
  //    d) Save the exp handle into the expect_a array at the index t.write_pointer
  //
  //ADD YOUR CODE HERE...
  //BEGIN SOLUTION
  virtual function void write_dut_in(input lab_tx_in t);
    if (t.reset_n===0) begin // reset is enabled (active low)
      // Delete scoreboard contents during reset
      expect_a.delete();
    end

    else if (t.load_en===1) begin
      lab_tx_out exp;

      // Copy & store transaction in scoreboard
      exp = lab_tx_out::type_id::create("exp");
      exp.instruction.opc  = t.opcode;
      exp.instruction.op_a = t.operand_a;
      exp.instruction.op_b = t.operand_b;
      expect_a[t.write_pointer] = exp;
    end
  endfunction: write_dut_in
  //END SOLUTION



  // Receive an actual output transaction from the DUT and compare with the expected transactions
  virtual function void write_dut_out(input lab_tx_out t);
    // Don't compare during reset
    if (t.reset_n === 0)
      return;

    // Check that a storage location in the expected result array exists
    if ( !expect_a.exists(t.read_pointer) ) begin
      `uvm_error("SCOREBOARD", $sformatf("read_pointer value %x is an address that has not been written\n", t.read_pointer))
    end

    // Compare the actual transaction with the expected transaction
    else if (t.compare(expect_a[t.read_pointer])) begin
      match++;
      expect_a.delete(t.read_pointer);
    end

    else begin
      `uvm_error("SCOREBOARD", $sformatf("Expected and actual did not match at address %h(hex)", t.read_pointer))
      `uvm_info("SCOREBOARD",  $sformatf("DUT out is:%s\nExpected %s",
					 t.sprint(), expect_a[t.read_pointer].sprint()), UVM_MEDIUM)
      mismatch++;
    end
  endfunction: write_dut_out


  virtual function void report_phase(uvm_phase phase);
    `uvm_info("SCOREBOARD", $sformatf("\n\n\t Test score: passed=%0d  failed=%0d\n", match, mismatch), UVM_NONE)

    // Look for any orphan transaction that never were sent out by the DUT
    if (expect_a.size() != 0) begin
      `uvm_error("SCOREBOARD", $sformatf("%0d. transactions left in scoreboard at the end of the test", expect_a.size()))
      foreach (expect_a[i]) begin
        `uvm_info("SCOREBOARD", $sformatf("aa[%0d]=%s", i, expect_a[i].sprint()), UVM_MEDIUM)
      end
    end
  endfunction: report_phase

endclass
`endif
