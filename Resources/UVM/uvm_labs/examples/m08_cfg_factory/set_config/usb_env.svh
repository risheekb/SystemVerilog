/***********************************************************************
 * Environment for UVM configuration flow example
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

class usb_env extends uvm_env;
  `uvm_component_utils(usb_env);
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  env_config      env_cfg;
  usb_agent       agt;
  usb_cov_collect cov;


  // Get the environment config
  virtual function void set_config(input env_config env_cfg);
    this.env_cfg = env_cfg;
  endfunction


  virtual function void build_phase(uvm_phase phase);
    // Create the agent
    agt = usb_agent::type_id::create("usb_agt", this);

    // Pass down the agent configuration, after the agent is created
    agt.set_config(env_cfg.usb_cfg);

    if (env_cfg.enable_coverage)
      cov = usb_cov_collect::type_id::create("cov", this);
  endfunction

endclass
