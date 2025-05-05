/***********************************************************************
 * AHB test for the ahb_write_sequence for the example of configuring a sequence
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


class ahb_test extends uvm_test;
  `uvm_component_utils(ahb_test)
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  ahb_env env;
  ahb_config ahb_cfg;

  virtual function void build_phase(uvm_phase phase);
    ahb_cfg = ahb_config::type_id::create("ahb_cfg");
    if (!uvm_config_db#(virtual ahb_ifc)::get(this, "", "ahb_vif", ahb_cfg.vif))
      `uvm_fatal("NOVIF", "No virtual interface passed into test")
    uvm_config_db#(ahb_config)::set(this, "env*", "ahb_cfg", ahb_cfg);

    ahb_cfg.active  = UVM_ACTIVE;
    ahb_cfg.addr_lo = SLAVE_0_ADDR_LO;
    ahb_cfg.addr_hi = SLAVE_0_ADDR_HI;
    ahb_cfg.id      = SLAVE_0_ID;

    env = ahb_env::type_id::create("env", this);
  endfunction


  virtual task run_phase(uvm_phase phase);
    /* find() example */
    uvm_component compq[$], c;


    `uvm_info("find_all", "\n\n", UVM_NONE)
    `uvm_info("find_all", "Example starting at the test (null): uvm_top.find_all(\"*\", compq);", UVM_NONE)
    uvm_top.find_all("*", compq);
    foreach (compq[i])
      `uvm_info("find_all", $sformatf("compq[%0d]='%s'", i, compq[i].get_full_name()), UVM_NONE)
    compq.delete();

    `uvm_info("find_all", "\n\n", UVM_NONE)
    `uvm_info("find_all", "Example starting at the test level: uvm_top.find_all(\"*\", compq, this);", UVM_NONE)
    uvm_top.find_all("*", compq, this);
    foreach (compq[i])
      `uvm_info("find_all", $sformatf("compq[%0d]='%s'", i, compq[i].get_full_name()), UVM_NONE)
    compq.delete();

    `uvm_info("find_all", "\n\n", UVM_NONE)
    `uvm_info("find_all", "Example starting at the test level: uvm_top.find_all(\"*sqr\", compq, this);", UVM_NONE)
    uvm_top.find_all("*", compq, this);
    foreach (compq[i])
      `uvm_info("find_all", $sformatf("compq[%0d]='%s'", i, compq[i].get_full_name()), UVM_NONE)
    compq.delete();

    `uvm_info("find", "\n\n", UVM_NONE)
    `uvm_info("find", "Example of find looking for a sequencer: uvm_top.find(\"*sqr\"); ", UVM_NONE)
    c = uvm_top.find("*sqr");
    `uvm_info("find", $sformatf("c='%s'", c.get_full_name()), UVM_NONE)

    `uvm_info("find", "\n\n", UVM_NONE)
    `uvm_info("FINISH", "****End simulation after find() examples***", UVM_NONE)

  endtask

endclass
