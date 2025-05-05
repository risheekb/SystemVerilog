/***********************************************************************
 * UVM Testbench to verify an Instruction Register array design.
 *
 * Class: lab_tx_in
 *
 * Defines a transaction (sequence item) object within the UVM testbench.
 * This sequence item is extended from the base transaction, and is
 * specific to the write operations to the instruction register.
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

`ifndef lab_tx_in_exists
`define lab_tx_in_exists


class lab_tx_in extends lab_tx_base;

  // Note: All class properties are inherited from the parent

  //
  // LAB 3 ASSIGNMENT:
  // 1) Register this class in the factory and define its constructor
  //
  // 2) This class has no additional properties. Do you need to write
  //    do_copy(), do_compare(), and convert2string() methods?
  //
//ADD YOUR CODE HERE...
//BEGIN SOLUTION
  `uvm_object_utils(lab_tx_in)
  function new(string name = "lab_tx_in");
    super.new(name);
  endfunction
//END SOLUTION



  // Constraints to set default values
  constraint c_reset { soft reset_n == 1'b1; }
  constraint c_load  { soft load_en == 1'b1; }
  constraint c_opa   { soft operand_a inside {[10:25]}; }
  constraint c_opb   { soft operand_b inside {[0:5]}; }

endclass: lab_tx_in
`endif
