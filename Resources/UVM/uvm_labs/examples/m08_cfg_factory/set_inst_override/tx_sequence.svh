/***********************************************************************
 * Sequence for UVM override example
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

class tx_sequence extends uvm_sequence #(tx_item);
  `uvm_object_utils(tx_sequence)
  function new(string name="tx_sequence");
    super.new(name);
  endfunction


  virtual task body();
    tx_item tx;

    //    `uvm_info("Starting", get_full_name(), UVM_MEDIUM)
    // `uvm_info(get_full_name(), {"type_id::create(\"tx\", ",
    // 			   get_sequencer().get_name(), ")"}, UVM_MEDIUM)
    $display("\ntype_id::create()");
    $display("get_name=%s", get_name());
    $display("get_full_name=%s", get_full_name());
    $display("get_sequencer().get_name=%s", get_sequencer().get_name());
    $display("get_sequencer().get_full_name=%s", get_sequencer().get_full_name());

    repeat (4) begin

      //      `uvm_create(tx)
      tx = tx_item::type_id::create("tx", get_sequencer());

      start_item(tx);
      if (!tx.randomize()) `uvm_fatal(get_type_name, "tx_item::randomize() failed")
      `uvm_info("dst", $sformatf("seq: tx.dst=%0x", tx.dst), UVM_LOW);
      finish_item(tx);
    end
  endtask

endclass : tx_sequence
