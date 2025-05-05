/***********************************************************************
 * UVM sequence item
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

class ahb_txn extends uvm_sequence_item;
  `uvm_object_utils(ahb_txn)
  function new(string name="ahb_txn");
    super.new(name);
  endfunction

  rand AHB_OPCODE_T opcode;
  rand AHB_DATA4_T data;  // 4-state to hold RTL results
  rand AHB_ADDR2_T addr;
  AHB_DATA4_T result;
  STATUS_T status = OK;


  virtual function void do_copy(uvm_object rhs);
    ahb_txn ahb_rhs;
    if (! $cast(ahb_rhs, rhs)) `uvm_fatal("CAST", "FAILED")
    super.do_copy(rhs);
    opcode = ahb_rhs.opcode;
    addr   = ahb_rhs.addr;
    data   = ahb_rhs.data;
    result = ahb_rhs.result;
  endfunction

  virtual function bit do_compare(uvm_object rhs, uvm_comparer comparer);
    ahb_txn ahb_rhs;
    if (! $cast(ahb_rhs, rhs)) `uvm_fatal("CAST", "FAILED")
    return (super.do_compare(rhs, comparer) &&
	    (opcode === ahb_rhs.opcode) &&
	    (addr   === ahb_rhs.addr) &&
	    (data   === ahb_rhs.data) &&
	    (result === ahb_rhs.result));
  endfunction


  // Create a string version of the transaction
  virtual function string convert2string();
    return $sformatf("ahb_txn: opc=%s (0x%0x) addr=0x%0x, data=0x%0x, result=0x%0x",
		     opcode.name(), opcode, addr, data, result);
  endfunction


  // Initialize the transaction fields to fixed values
  virtual function void init(AHB_OPCODE_T opcode = AHB_NONE,
			     AHB_ADDR2_T addr = 0,
			     AHB_DATA4_T data = 'x,
			     AHB_DATA4_T result = 'x);
    this.opcode = opcode;
    this.addr = addr;
    this.data = data;
    this.result = result;
  endfunction


  virtual function void do_record(input uvm_recorder recorder);
    super.do_record(recorder);
    `uvm_record_field("name", get_name()); // Returns instance name
    `uvm_record_field("opcode", opcode);
    `uvm_record_field("addr", addr);
    `uvm_record_field("data", data);
    `uvm_record_field("result", result);
  endfunction


  // Print transactions with convert2string()
  virtual function void do_print(input uvm_printer printer);
    printer.m_string = convert2string();
  endfunction


endclass : ahb_txn
