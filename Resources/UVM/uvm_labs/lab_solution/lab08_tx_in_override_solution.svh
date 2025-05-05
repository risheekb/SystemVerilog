/***********************************************************************
 * UVM Testbench to verify an Instruction Register array design.
 *
 * Class: lab_tx_in_override
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

`ifndef lab_tx_in_override_exists
`define lab_tx_in_override_exists


class lab_tx_in_override extends lab_tx_in;

  // Note: All class properties are inherited from the parent

  // Register this class name in the factory
  `uvm_object_utils(lab_tx_in_override)
  function new(string name = "lab_tx_in_override");
    super.new(name);
  endfunction

  // Override the restrictive constraints on operand_a & b with open ones, and generate more DIV
  constraint c_opa { operand_a <= 31; }
  constraint c_opb { operand_b <= 31; }
  constraint c_opc { opcode dist {DIV:=10, [ZERO:U_ADD]:=3}; }

  function void post_randomize();
    super.post_randomize();
    `uvm_info("SUCCESS", "Successfully randomized a lab_tx_in_override object", UVM_LOW)
  endfunction

endclass: lab_tx_in_override
`endif
