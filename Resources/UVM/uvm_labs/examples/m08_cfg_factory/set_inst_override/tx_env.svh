/***********************************************************************
 * Environment for UVM override example
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

class tx_env extends uvm_env;
  `uvm_component_utils(tx_env);
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  tx_env_config env_cfg;
  tx_agent      agt[NUM_TX_AGT];   // For identical agents

  virtual function void build_phase(uvm_phase phase);
    // Get the environment config and pass down the agent configuration
    if (!uvm_config_db #(tx_env_config)::get(this, "", "env_cfg", env_cfg))
      `uvm_fatal("NOCFG", "No env_cfg in DB");

    // Put agent tx_cfg handle into config_db for the USB agent and sub-components
    foreach (env_cfg.tx_cfg[i])
      uvm_config_db #(tx_config)::set(this, $sformatf("agt%0d*", i), "tx_cfg", env_cfg.tx_cfg[i]);

    // Finally, create the Agent. Do this after the DB calls to show they are separate
    foreach (agt[i])
      agt[i] = tx_agent::type_id::create($sformatf("agt%0d", i), this);
  endfunction

endclass
