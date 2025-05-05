/***********************************************************************
 * UVM Testbench to verify an Instruction Register array design.
 *
 * Class: lab_tx_out
 * ***SPECIAL VERSION WITH FIELD MACROS***
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

`ifdef lab_tx_out_exists
ERROR DO NOT INCLUDE BOTH lab03_tx_out.svh AND lab03_tx_out_field_macro.svh
`else
`define lab_tx_out_exists


class lab_tx_out extends lab_tx_base;

  //
  // LAB 3 ASSIGNMENT, PART 1
  // Define the class constructor method new()
  //
//ADD YOUR CODE HERE...
//BEGIN SOLUTION
  function new(string name="lab_tx_base");
    super.new(name);
  endfunction
//END SOLUTION


  //
  // LAB 3 ASSIGNMENT, PART 2
  // Add the property instruction of type instruction_t to the class. It is the DUT output
  //
  // NOTE: instruction_t is a user-defined structure from:
  //       uvm_labs/lab_dut/instr_reg_pkg.sv
  //
//ADD YOUR CODE HERE...
//BEGIN SOLUTION
  instruction_t instruction;
//END SOLUTION


  //
  // LAB 3 ASSIGNMENT PART 3:
  // Use the field macros to define the protocol-specific behavior
  // Start with the factory registration+field macro:
  //   `uvm_object_utils_begin(this-class-name)
  // For the integral property you defined above, use the field macro:
  //     `uvm_field_int(property, UVM_ALL_ON)
  // Finally, end the field macros with:
  //   `uvm_object_utils_end
  //
//ADD YOUR CODE HERE...
//BEGIN SOLUTION
  `uvm_object_utils_begin(lab_tx_out)
    `uvm_field_int(instruction, UVM_ALL_ON)
  `uvm_object_utils_end
//END SOLUTION


endclass: lab_tx_out
`endif
