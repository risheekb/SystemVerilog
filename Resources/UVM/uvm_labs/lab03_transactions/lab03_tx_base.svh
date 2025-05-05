/***********************************************************************
 * UVM Testbench to verify an Instruction Register array design.
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
  // LAB 3 ASSIGNMENT, PART 1:
  // 1) Register this class in the factory with the UVM object utils macro
  // 2) Define the class constructor method new()
  //
//ADD YOUR CODE HERE...
  `uvm_object_utils(lab_tx_base);
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

  // Don't repeat the same write pointer value as the new entry will write over
  // last values in the scoreboard expect array
  constraint dont_repeat_write_pointer {write_pointer != last_write_pointer; }


  //
  // LAB 3 ASSIGNMENT, PART 2:
  // 1) Write the virtual function void do_copy() to copy properties.
  //    Copy the above properties except last_write_pointer.
  //
  // 2) Write the virtual function bit do_compare() to compare properties.
  //    Only compare operand_a, operand_b, and opcode.
  //
//ADD YOUR CODE HERE...
  
  virtual function void do_copy(uvm_object rhs);
    lab_tx_base tx_item;
    if(!$cast(tx_item,rhs))
      `uvm_fatal(get_type_name(),"Illegal rhs arguement!!");
    super.do_copy(rhs);

    this.reset_n = tx_item.reset_n;
    this.load_en = tx_item.load_en;
    this.read_pointer = tx_item.read_pointer;
    this.write_pointer = tx_item.write_pointer;
    this.operand_a = tx_item.operand_a;
    this.operand_b = tx_item.operand_b;
    this.opcode = tx_item.opcode;

  endfunction

  virtual function bit do_compare(input uvm_object rhs,input uvm_comparer comparer);
    lab_tx_base tx_item;
    if(!$cast(tx_item,rhs))
      `uvm_fatal(get_type_name(),"Illeagal rhs arguement!!");
    return(super.do_compare(rhs,comparer)&&
          (this.operand_a === tx_item.operand_a)&&
          (this.operand_b === tx_item.operand_b)&&
          (this.opcode === tx_item.opcode));
  endfunction

  virtual function string convert2string();
    string s = super.convert2string();
    $sformat(s, "%s\n lab_tx_base (hex):", s);
    $sformat(s, "%s\n reset_n       = %b, load_en = %b", s, reset_n, load_en);
    $sformat(s, "%s\n write_pointer = %0x, read_pointer = %0x, last_write_pointer = %0x", 
	     s, write_pointer, read_pointer, last_write_pointer);
    $sformat(s, "%s\n opcode        = %s (%0x), operand_a, b = %0x, %0x", 
	     s, opcode.name(), opcode, operand_a, operand_b);
    return s;
  endfunction

  // Copy pointer value so that the next transaction reads from the element just written
  function void post_randomize();
    super.post_randomize();
    read_pointer = last_write_pointer;
    last_write_pointer = write_pointer;
  endfunction


  // Record properties for transaction debug
  virtual function void do_record(input uvm_recorder recorder);
    super.do_record(recorder);
    `uvm_record_field("name", get_name()); // Returns instance name
    `uvm_record_field("reset_n", reset_n);
    `uvm_record_field("load_en", load_en);
    `uvm_record_field("read_pointer", read_pointer);
    `uvm_record_field("write_pointer", write_pointer);
    `uvm_record_field("operand_a", operand_a);
    `uvm_record_field("operand_b", operand_b);
    `uvm_record_field("opcode", opcode);
    `uvm_record_field("last_write_pointer", last_write_pointer);
  endfunction


  // Print transactions with convert2string()
  virtual function void do_print(input uvm_printer printer);
    printer.m_string = convert2string();
  endfunction

  // Define empty methods here in case they need to be overriden later
  virtual function void do_pack(input uvm_packer packer);
  endfunction

  virtual function void do_unpack(input uvm_packer packer);
  endfunction

endclass: lab_tx_base
`endif
