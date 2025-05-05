/***********************************************************************
 * AHB sequence that starts N pairs of write-read transactions
 * For the example of configuring a virtual sequence
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

class ahb_wr_rd_sequence extends uvm_sequence #(ahb_txn);
  `uvm_object_utils(ahb_wr_rd_sequence)
  function new(string name="ahb_wr_rd_sequence");
    super.new(name);
  endfunction

  ahb_config ahb_cfg;

  virtual task pre_start();
    if (!uvm_config_db#(ahb_config)::get(get_sequencer(), "", "ahb_cfg", ahb_cfg))
      `uvm_fatal("NOAHBCFG", "Unable to find ahb_cfg in uvm_config_db")

    ahb_txn::addr_lo = ahb_cfg.addr_lo; // Set static variables in transaction
    ahb_txn::addr_hi = ahb_cfg.addr_hi;
  endtask


  virtual task body();
    ahb_txn wr, rd;

    repeat (ahb_cfg.n_trans) begin
      ahb_write_sequence wr_seq;
      ahb_read_sequence rd_seq;
      ahb_txn wr;

      wr_seq = ahb_write_sequence::type_id::create("wr_seq");
      wr_seq.init_start(wr, 1, get_sequencer());

      rd_seq = ahb_read_sequence::type_id::create("rd_seq");
      rd_seq.init_start_check(wr, get_sequencer());
    end
  endtask : body

endclass : ahb_wr_rd_sequence
