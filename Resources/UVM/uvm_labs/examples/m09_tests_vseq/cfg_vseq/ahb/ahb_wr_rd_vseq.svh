/***********************************************************************
 * Write+read virtual sequence for the example of configuring a virtual sequence
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

class ahb_wr_rd_vsequence extends uvm_sequence;
  `uvm_object_utils(ahb_wr_rd_vsequence)
  function new(string name="ahb_wr_rd_vsequence");
    super.new(name);
  endfunction

  ahb_config ahb_cfg;

  virtual task init_start(input ahb_config ahb_cfg);
    this.ahb_cfg = ahb_cfg;
    ahb_txn::addr_lo = ahb_cfg.addr_lo; // Set static variables in transaction
    ahb_txn::addr_hi = ahb_cfg.addr_hi;
    this.start(null);			// vseq doesn't need a sequencer
  endtask


  virtual task body();
    ahb_write_sequence seq_wr;
    ahb_read_sequence seq_rd;

    seq_wr = ahb_write_sequence::type_id::create("seq_wr");
    seq_wr.start(ahb_cfg.sqr, this);

    seq_rd = ahb_read_sequence::type_id::create("seq_rd");
    seq_rd.start(ahb_cfg.sqr, this);

  endtask : body
endclass : ahb_wr_rd_vsequence
