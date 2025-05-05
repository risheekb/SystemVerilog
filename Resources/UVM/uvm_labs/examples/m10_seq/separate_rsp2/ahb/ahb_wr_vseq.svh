/***********************************************************************
 * Write Read virtual sequence
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

class ahb_wr_vseq extends uvm_sequence #(ahb_txn);
  `uvm_object_utils(ahb_wr_vseq)
  function new(string name="ahb_wr_vseq");
    super.new(name);
  endfunction

  ahb_config ahb_cfg;
  int n_items;


  virtual task body();
    for (int i=0; i<n_items; i++) begin
      ahb_txn            tx; // Holds random addr & data
      ahb_write_sequence wr;
      ahb_read_sequence  rd;

      // Send out a single random write
      tx = ahb_txn::type_id::create("tx");
      if (!tx.randomize() with {addr inside {[0:1000]};} )
	`uvm_fatal("FAIL", "ahb_txn randomize()")
      wr = ahb_write_sequence::type_id::create("wr");
      wr.write1(ahb_cfg, tx);

      // Check with a single directed read
      rd = ahb_read_sequence::type_id::create("rd");
      rd.check(ahb_cfg, tx);
    end
  endtask : body


  virtual task init_start(input ahb_config ahb_cfg,
			  input int n_items);
    this.ahb_cfg = ahb_cfg;
    this.n_items = n_items;
    this.start(ahb_cfg.sqr);
  endtask

endclass : ahb_wr_vseq
