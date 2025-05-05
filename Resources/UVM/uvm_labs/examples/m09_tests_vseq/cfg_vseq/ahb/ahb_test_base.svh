/***********************************************************************
 * Base class for AHB tests for the example of configuring a virtual sequence
 * Sets up virtual interface and configuration
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


class ahb_test_base extends uvm_test;
  `uvm_component_utils(ahb_test_base)
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
    phase.phase_done.set_drain_time(this, 20); // delay objection drop 20ns
  endtask

endclass : ahb_test_base
