/***********************************************************************
 * Sequence for TX UVM example
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
    uvm_phase phase;
    bit objection = '0;

    // Hack to send in more transactions
    // Should use +uvm_set_config_int... but this works too
    int items = 1_000_000;
    if ($value$plusargs("items=%d", items)) begin
      `uvm_info("ITEMS", $sformatf("Found +items=%0d", items), UVM_LOW)
    end else begin
      `uvm_info("NOITEMS", $sformatf("Didn't find +items, using items=%0d", items), UVM_LOW)
    end

    objection = $test$plusargs("objection");
    `uvm_info("OBJECTION", $sformatf("+objection is %0s", objection ? "ON" : "OFF"), UVM_LOW)

    if (!uvm_config_db#(uvm_phase)::get(get_sequencer(), "", "phase", phase))
      `uvm_fatal("NO_PHASE", "phase not found in uvm_config_db")

    repeat (items) begin
      if (objection) phase.raise_objection(this, "tx_test starting tx_sequence");

      req = tx_item::type_id::create("req");
      start_item(req);
      if (!req.randomize()) `uvm_fatal(get_type_name, "tx_item::randomize() failed")
      //	 `uvm_info("DATA", $sformatf("seq: req.data=%3d", req.data), UVM_LOW);
      finish_item(req);

      if (objection) phase.drop_objection(this, "tx_test ended tx_sequence");
    end
  endtask

endclass : tx_sequence
