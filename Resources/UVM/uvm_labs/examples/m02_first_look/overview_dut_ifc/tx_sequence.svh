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
    int count = 5;
    // Hack to send in more transactions
    if ($value$plusargs("count=%d", count))
      $display("Found +count=%0d", count);
    repeat (count) begin
      req = tx_item::type_id::create("req");
      start_item(req);
      if (!req.randomize()) `uvm_fatal(get_type_name, "tx_item::randomize() failed")
      finish_item(req);
    end
  endtask

endclass : tx_sequence
