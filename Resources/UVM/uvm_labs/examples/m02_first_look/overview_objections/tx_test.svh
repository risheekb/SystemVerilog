/***********************************************************************
 * Test for TX UVM example
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

class tx_test extends uvm_test;
  `uvm_component_utils(tx_test);
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  tx_env env;
  virtual tx_ifc tx_if;

  virtual function void build_phase(uvm_phase phase);
    env = tx_env::type_id::create("env", this);

    // Fetch the virtual interface from the UVM config DB (set by HDL)
    if (! uvm_config_db#(virtual tx_ifc)::get(this, "", "tx_if", tx_if))
      `uvm_fatal("IFC", "virtual tx_ifc tx_if not found in uvm_config_db")

    // Set the virtual interface so it can be read by lower components
    // (This is a short term hack, see later chapters for a better way)
    uvm_config_db#(virtual tx_ifc)::set(this, "env*", "tx_if", tx_if);
  endfunction


  virtual task run_phase(uvm_phase phase);
    tx_sequence seq;
    uvm_config_db#(uvm_phase)::set(this, "env*", "phase", phase);

    seq = tx_sequence::type_id::create("seq");
    phase.raise_objection(this, "tx_test starting tx_sequence");
    seq.start(env.agt.sqr);
    phase.drop_objection(this, "tx_test ended tx_sequence");
  endtask
endclass
