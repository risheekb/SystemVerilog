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
  tx_agent_config agt_cfg;
  tx_env_config env_cfg;

  virtual function void build_phase(uvm_phase phase);
    env = tx_env::type_id::create("env", this);

    agt_cfg = tx_agent_config::type_id::create("agt_cfg");
    if (! uvm_config_db#(virtual tx_ifc)::get(this, "", "vif", agt_cfg.vif))
      `uvm_fatal("NO_VIF", "No virtual interface found");
    env_cfg = tx_env_config::type_id::create("env_cfg");
    env_cfg.agt_cfg = agt_cfg;
    uvm_config_db #(tx_env_config)::set(this, "env", "env_config", env_cfg);
  endfunction

  // virtual function void end_of_elaboration_phase(uvm_phase phase);
  //    `uvm_info("TEST_TOPO", "Printing topology from end_of_elaboration_phase", UVM_NONE);
  //    uvm_top.print_topology();
  // endfunction

  virtual task run_phase(uvm_phase phase);
    tx_sequence seq;
    `uvm_info("RUN", $sformatf("In %m"), UVM_FULL);

    // Wait for last transaction to pass through the design
    phase.phase_done.set_drain_time(this, 100); // delay objection drop 100ns

    phase.raise_objection(this, get_full_name());
    seq = tx_sequence::type_id::create("seq");
    seq.start(env.agt.sqr);
    phase.drop_objection(this, get_full_name());
  endtask

endclass
