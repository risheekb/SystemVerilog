/***********************************************************************
 * UVM Testbench to verify an Instruction Register array design.
 *
 * Class: lab_tx_base
 * ***SPECIAL VERSION WITH FIELD MACROS***
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

`ifdef lab_tx_base_exists
  ERROR DO NOT INCLUDE BOTH lab03_tx_base.svh AND lab03_tx_base_field_macro.svh 
`else
`define lab_tx_base_exists


class lab_tx_base extends uvm_sequence_item;

  // Class properties. These types are defined in uvm_labs/lab_dut/instr_reg_pkg.sv
  rand   bit         reset_n;
  rand   bit         load_en;
  rand   pointer2_t  read_pointer;
  randc  pointer2_t  write_pointer;
  rand   operand2_t  operand_a;
  rand   operand2_t  operand_b;
  rand   opcode_t    opcode = ZERO;
  static pointer2_t  last_write_pointer;

  // Don't repeat the same write pointer value as the new entry will write over
  // last values in the scoreboard expect array
  constraint dont_repeat_write_pointer {write_pointer != last_write_pointer; }

  //
  // LAB 3 ASSIGNMENT, PART 1:
  // Define the class constructor method new()
  //
//ADD YOUR CODE HERE...
  function new(string name = "lab_tx_base");
    super.new(name);
  endfunction

  // LAB 3 ASSIGNMENT, PART 2:
  // Use the field macros to define the protocol-specific behavior
  // Start with the factory registration+field macro:
  //   `uvm_object_utils_begin(this-class-name)
  // For every integral property that you want to copy & compare, use the field macro:
  //     `uvm_field_int(operand_a, UVM_ALL_ON)
  //     `uvm_field_int(operand_b, UVM_ALL_ON)
  // For the enumerated property
  //     `uvm_field_enum(opcode_t, opcode, UVM_ALL_ON)
  // For this static property, don't copy or compare
  //     `uvm_field_int(last_write_pointer, UVM_ALL_ON | UVM_NOCOPY | UVM_NOCOMPARE)
  // For the remaining 4 properties, don't compare, but do copy
  //     `uvm_field_int(write_pointer, UVM_ALL_ON | UVM_NOCOMPARE)
  // Finally, end the field macros with:
  //   `uvm_object_utils_end
  //
  // You don't need to write do_copy() and do_compare()
  // methods as the field macros generate the equivalent code.
  // do_print(), do_pack, and do_unpack() are not needed.
  //

//ADD YOUR CODE HERE...

  `uvm_object_utils_begin(lab_tx_base)
  `uvm_field_int(operand_a,UVM_ALL_ON)
  `uvm_field_int(operand_b,UVM_ALL_ON)
  `uvm_field_enum(opcode_t,opcode,UVM_ALL_ON)
  `uvm_field_int(last_write_pointer, UVM_ALL_ON | UVM_NOCOPY | UVM_NOCOMPARE)

  `uvm_field_int(write_pointer, UVM_ALL_ON | UVM_NOCOMPARE)
  `uvm_field_int(load_en, UVM_ALL_ON | UVM_NOCOMPARE)
  `uvm_field_int(read_pointer, UVM_ALL_ON | UVM_NOCOMPARE)
  `uvm_field_int(reset_n, UVM_ALL_ON | UVM_NOCOMPARE)
  `uvm_object_utils_end
  // The field macros create protocol-specific code, the equivalent of convert2string()
  // A testbench with field macros never calls convert2string(), but just in case...
  virtual function string convert2string();
    return sprint();
  endfunction

  // Copy pointer value so that the next transaction reads from the element just written
  function void post_randomize();
    super.post_randomize();
    read_pointer = last_write_pointer;
    last_write_pointer = write_pointer;
  endfunction

endclass: lab_tx_base
`endif
