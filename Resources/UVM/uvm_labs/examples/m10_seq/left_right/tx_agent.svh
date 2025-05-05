/***********************************************************************
 * Agent for TX UVM example
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

class tx_agent extends uvm_agent;
  `uvm_component_utils(tx_agent);
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  tx_driver drv;
  uvm_sequencer#(tx_item) sqr;
  tx_monitor mon;
  tx_agent_config agt_cfg;

  virtual function void build_phase(uvm_phase phase);
    `uvm_info("BUILD", $sformatf("In %m"), UVM_FULL);

    if (!uvm_config_db #(tx_agent_config)::get(this, "", "agt_cfg", agt_cfg))
      `uvm_fatal("NO_ENV_CFG", "No env_config passed into agent");

    mon = tx_monitor::type_id::create("mon", this);

    if (agt_cfg.active == UVM_ACTIVE) begin
      drv = tx_driver::type_id::create("drv", this);
      sqr = uvm_sequencer#(tx_item)::type_id::create("sqr", this);
      agt_cfg.sqr = sqr;
    end
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    if (agt_cfg.active == UVM_ACTIVE)
      drv.seq_item_port.connect(sqr.seq_item_export);
  endfunction

endclass
