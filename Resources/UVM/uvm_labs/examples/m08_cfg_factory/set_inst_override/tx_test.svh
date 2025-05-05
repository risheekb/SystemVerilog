/***********************************************************************
 * Test for UVM override example
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
  tx_config tx_cfg[NUM_TX_AGT];
  tx_env_config env_cfg;


  virtual function void build_phase(uvm_phase phase);

    // Create the tree of configuration objects, and store the root in the uvm_config_db
    env_cfg = tx_env_config::type_id::create("env_cfg");
    foreach (tx_cfg[i]) begin
      tx_cfg[i] = tx_config::type_id::create($sformatf("tx_cfg%0d", i)); // Agent cfg
      env_cfg.tx_cfg[i] = tx_cfg[i];
    end
    uvm_config_db #(tx_env_config)::set(this, "env", "env_cfg", env_cfg);

    // Fill in the configuration
    foreach (tx_cfg[i]) begin
      if (! uvm_config_db#(virtual tx_interface)::get(this, "",
						      $sformatf("vif[%0d]", i), tx_cfg[i].vif))
	`uvm_fatal("NOVIF", $sformatf("No USB VIF[%0d] in DB", i));
    end

    // Finally, create the environment. Do this after the DB calls to show they are separate
    env = tx_env::type_id::create("env", this);
  endfunction


  virtual task run_phase(uvm_phase phase);
    tx_vseq vseq;
    uvm_factory factory = uvm_factory::get();

    // Only override the sequence item for agent "agt2"
    tx_item::type_id::set_inst_override( tx_item_dst9::get_type(),
//                                       Success: Path to the sequence item "tx"
    					 "uvm_test_top.env.agt2.sqr.tx");

//                                       Fail: includes sequence name
//    					 "uvm_test_top.env.agt2.sqr@@seq2.tx");

//                                       Success: Path to the sequencer, and any sequence
//    					 "uvm_test_top.env.agt2.sqr*");

//                                       Success: Path to any component/item under agt2, except agt2
//    					 "uvm_test_top.env.agt2.*");

//                                       Success: Path to any component/item under agt2, including agt2
//    					 "uvm_test_top.env.agt2*");

    //   `uvm_info("TEST_TOPO", "Printing topology from end_of_elab", UVM_NONE);
    // uvm_top.print_topology();

    // Print factory overrides
    factory.print(1);

    // Wait for last transaction to pass through the design
    phase.phase_done.set_drain_time(this, 20); // Delay the objection drop for 20ns

    // Run the virtual sequence
    phase.raise_objection(this, get_type_name());
    vseq = tx_vseq::type_id::create("vseq", this);
    vseq.init_start(env_cfg);
    phase.drop_objection(this, get_type_name());
  endtask

endclass
