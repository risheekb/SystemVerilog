/***********************************************************************
 * Monitor for TX UVM example
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

class tx_monitor extends uvm_monitor;
  `uvm_component_utils(tx_monitor);
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  tx_agent_config agt_cfg;
  virtual tx_interface vif;

  tx_item tr_last;

  virtual function void build_phase(uvm_phase phase);
    if (!uvm_config_db #(tx_agent_config)::get(this, "", "agt_cfg", agt_cfg))
      `uvm_fatal("NO_ENV_CFG", "No env_config passed into agent");
    vif = agt_cfg.vif;
  endfunction

  virtual task run_phase(uvm_phase phase);
    `uvm_info("RUN", $sformatf("In %m"), UVM_FULL);
    fork
      get_inputs();
      get_outputs();
    join
  endtask


  virtual task get_inputs();
    forever begin
      tx_item tr;

      vif.get_an_input(tr);
      `uvm_info("MON_IN", $sformatf("Drove %h", tr.data), UVM_FULL)
      tr_last = tr;
    end
  endtask

  virtual task get_outputs();
    forever begin
      tx_item tr;

      vif.get_an_output(tr);
      `uvm_info("MON_OUT", $sformatf("Sampled %h", tr.data), UVM_FULL);

      // Mini scoreboard
      if (tr_last == null) begin
        `uvm_error("NULL_LAST", "Tried to compare but last transacton handle is null")
      end
      else begin
	if (tr_last.data !== tr.data)
          `uvm_error("MISCOMP", $sformatf("Actual data (%h) != expected data (%h)",
	                                  tr.data, tr_last.data))
      end
    end
  endtask


endclass
