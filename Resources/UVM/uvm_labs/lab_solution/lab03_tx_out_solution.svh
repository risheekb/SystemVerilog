/***********************************************************************
 * UVM Testbench to verify an Instruction Register array design.
 *
 * Class: lab_tx_out
 *
 * Defines a transaction (sequence item) object within the UVM testbench.
 * This sequence item is extended from the base transaction, and is
 * specific to reading instructions from the instruction register.
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

`ifndef lab_tx_out_exists
`define lab_tx_out_exists


class lab_tx_out extends lab_tx_base;
  `uvm_object_utils(lab_tx_out)
  function new(string name = "lab_tx_out");
    super.new(name);
  endfunction

  //
  // LAB 3 ASSIGNMENT, PART 1:
  // 1) Add the property instruction of type instruction_t to the class. It is the DUT output
  //
  // NOTE: instruction_t is a user-defined structure from
  //       uvm_labs/lab_dut/instr_reg_pkg.sv
  //

//ADD YOUR CODE HERE...
//BEGIN SOLUTION
  instruction_t instruction;
//END SOLUTION



  //
  // LAB 3 ASSIGNMENT PART 2:
  // 1) The do_copy() method below is nearly complete
  //    Just add code for the instruction property
  //
  virtual function void do_copy(input uvm_object rhs);
    lab_tx_out tx_rhs;
    if (!$cast(tx_rhs, rhs))
      `uvm_fatal("TX_CAST", "Illegal do_copy argument")

    super.do_copy(rhs);

//ADD YOUR CODE HERE...
//BEGIN SOLUTION
    instruction = tx_rhs.instruction;
//END SOLUTION

  endfunction : do_copy



  //
  // LAB 3 ASSIGNMENT PART 3:
  // 1) The do_compare() method below is nearly complete
  //    Just add code for super.do_compare() and the instruction property
  //
  virtual function bit do_compare(input uvm_object rhs, input uvm_comparer comparer);
    lab_tx_out tx_rhs;
    if (!$cast(tx_rhs, rhs))
      `uvm_fatal("TX_CAST", "Illegal do_compare argument")

//ADD YOUR CODE HERE...
//BEGIN SOLUTION
    return (super.do_compare(rhs, comparer) &&
            (instruction === tx_rhs.instruction));
//END SOLUTION

  endfunction


  // Extended convert2string() method, nothing to add for the lab
  virtual function string convert2string();
    // Generate a string with the properties for this class
    // Do not call super.convert2string() - too much info
    string s;
    $sformat(s, "%s\n lab_tx_out values (hex):", s);
    $sformat(s, "%s\n read_pointer  = %0x", s, read_pointer);
    $sformat(s, "%s\n opcode        = %s (%0x), operand_a, b = %0x, %0x",
	     s, instruction.opc.name(), instruction.opc, instruction.op_a, instruction.op_b);
    return s;
  endfunction


  // Record properties for transaction debug
  virtual function void do_record(input uvm_recorder recorder);
    super.do_record(recorder);
    `uvm_record_field("name", get_name()); // Returns instance name
    `uvm_record_field("instruction", instruction);
  endfunction

endclass: lab_tx_out
`endif
