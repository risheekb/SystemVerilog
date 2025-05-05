/***********************************************************************
 * AHB test for wr_rd virtual sequence for the example of configuring a virtual sequence
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

class ahb_test_dummy_vseq extends ahb_test_base;
  `uvm_component_utils(ahb_test_dummy_vseq)
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  virtual task run_phase(uvm_phase phase);
    ahb_wr_rd_dummy_vseq vseq;

    super.run_phase(phase);
    ahb_cfg.n_trans = 20; // Generate N transactions
    vseq = ahb_wr_rd_dummy_vseq::type_id::create("vseq");
    phase.raise_objection(this, "Start ahb_sequence");
    vseq.start(null);
    phase.drop_objection(this, "End ahb_sequence");
  endtask

endclass : ahb_test_dummy_vseq
