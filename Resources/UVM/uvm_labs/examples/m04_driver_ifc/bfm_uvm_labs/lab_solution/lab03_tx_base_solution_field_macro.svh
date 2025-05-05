/***********************************************************************
 *
 * ***SPECIAL VERSION WITH FIELD MACROS***
 *
 * Example UVM Testbench to verify an Instruction Register design.
 *
 * Class: lab_tx_base
 *
 * Defines a transaction (sequence item) object within the UVM testbench.
 * This sequence item represents a base transaction, from which specific
 * types of UART transactions can be extended.
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

`ifndef lab_tx_base_exists
`define lab_tx_base_exists


class lab_tx_base extends uvm_sequence_item;

  //
  // LAB 3 ASSIGNMENT, PART 1
  // 1) Register this class in the factory
  //
  // 2) Define the class new() constructor method
  //
//ADD YOUR CODE HERE...
//BEGIN SOLUTION
// Switch to `uvm_object_utils_begin(lab_tx_base) below
//  `uvm_object_utils(lab_tx_base)
  function new(string name="lab_tx_base");
    super.new(name);
  endfunction


  // Class properties. These types are defined in uvm_labs/lab_dut/instr_reg_pkg.sv
  rand   bit         reset_n;
  rand   bit         load_en;
  rand   pointer2_t  read_pointer;
  randc  pointer2_t  write_pointer;
  rand   operand2_t  operand_a;
  rand   operand2_t  operand_b;
  rand   opcode_t    opcode = ZERO;
  static pointer2_t  last_write_pointer;

  `uvm_object_utils_begin(lab_tx_base)
    `uvm_field_int(reset_n,       UVM_ALL_ON | UVM_NOCOMPARE)
    `uvm_field_int(load_en,       UVM_ALL_ON | UVM_NOCOMPARE)
    `uvm_field_int(read_pointer,  UVM_ALL_ON | UVM_NOCOMPARE)
    `uvm_field_int(write_pointer, UVM_ALL_ON | UVM_NOCOMPARE)

    `uvm_field_int(operand_a,         UVM_ALL_ON)
    `uvm_field_int(operand_b,         UVM_ALL_ON)
    `uvm_field_enum(opcode_t, opcode, UVM_ALL_ON)
  `uvm_object_utils_end
//END SOLUTION

  //
  // LAB 3 ASSIGNMENT, PART 2
  // Nothing to do here. You don't need to write do_copy() and do_compare()
  // methods as the field macros generate the equivalent code.
  // do_print(), do_pack(), and do_unpack() are not needed.
  //

  virtual function string convert2string();
    string s = super.convert2string();
    $sformat(s, "%s\n lab_tx_base (hex):", s);
    $sformat(s, "%s\n reset_n      = %b, load_en = %b", s, reset_n, load_en);
    $sformat(s, "%s\n read_pointer = %0x, write_pointer = %0x, last_write_pointer = %0x", s, read_pointer, write_pointer, last_write_pointer);
    $sformat(s, "%s\n opcode       = %0x (%s), operand_a, b = %0x, %0x", s, opcode, opcode.name(), operand_a, operand_b);
    return s;
  endfunction

  // Copy pointer values so that the next transaction reads from the location just written
  function void post_randomize();
    super.post_randomize();
    read_pointer = last_write_pointer;
    last_write_pointer = write_pointer;
  endfunction

endclass: lab_tx_base
`endif
