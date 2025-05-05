/***********************************************************************
 * UVM sequence item for the ALU scoreboard example
 ***********************************************************************
 * Copyright 2016-2017 Siemens
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

class alu_txn extends uvm_sequence_item;
  rand OPCODE_T opcode;
  rand OP_T     a, b;
  RESULT_T result;

  static int 	  m_count=0;
  int 		  addr;
  
  constraint c_small {
    soft a inside {[0:63]};
    soft b inside {[0:63]};
  }

  function new(string name="alu_txn");
    super.new(name);
    addr = m_count++;
  endfunction

  `uvm_object_utils_begin(alu_txn)
    `uvm_field_enum(OPCODE_T, opcode, UVM_ALL_ON)
    `uvm_field_int(a, UVM_ALL_ON)
    `uvm_field_int(b, UVM_ALL_ON)
    `uvm_field_int(result, UVM_ALL_ON)
  `uvm_object_utils_end

  virtual function string convert2string();
    return $sformatf("alu_txn: opc=%s (0x%x) a=0x%0x, b=0x%0x, result=0x%0x",
		     opcode.name(), opcode, a, b, result);
  endfunction

  // Print transactions with convert2string()
  virtual function void do_print(input uvm_printer printer);
    printer.m_string = convert2string();
  endfunction

endclass : alu_txn
