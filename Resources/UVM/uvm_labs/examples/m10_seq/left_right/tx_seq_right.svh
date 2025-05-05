/***********************************************************************
 * Sequence for TX UVM example
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

class tx_seq_right extends uvm_sequence #(tx_item);
  `uvm_object_utils(tx_seq_right)
  function new(string name="tx_seq_right");
    super.new(name);
  endfunction

  virtual task body();
    tx_vseq vseq;
    if (! $cast(vseq, get_parent_sequence()))
      `uvm_fatal("NOPE", "$cast(tx_vseq vseq, get_parent_sequence() failed")
    assert (vseq != null);
    
    vseq.vif.wait_clocks(1);	// Delay start of this sequence

    vseq.key.get();
    `uvm_info("RIGHT", "TWO", UVM_MEDIUM)
    vseq.vif.wait_clocks(1);
    vseq.key.put();		// Release key so Left can run

    vseq.key.get();		// Block until Left is done
    `uvm_info("RIGHT", "FOUR", UVM_MEDIUM)

    vseq.vif.wait_clocks(1);	// Wait before ending
    `uvm_info("RIGHT", "DONE", UVM_MEDIUM)
    vseq.key.put();

  endtask // body
endclass : tx_seq_right
