/***********************************************************************
 * Environment for UVM configuration flow example
 ***********************************************************************
 * Copyright 2016-2019 Siemens
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

class usb_env #(type AGT=int) extends uvm_env;
  `uvm_component_param_utils (usb_env #(AGT) )
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction

   env_config      env_cfg;  // This could be abbreviated to just cfg here
   AGT             agt;
   usb_cov_collect cov;

   virtual function void build_phase(uvm_phase phase);
      // Get the environment config and pass down the agent configuration
      if (!uvm_config_db #(env_config)::get(this, "", "env_cfg", env_cfg))
	`uvm_fatal("NOCFG", "No env_cfg in DB");

      // Put agent usb_cfg handle into config_db for the USB agent and sub-components
      uvm_config_db #(usb_config)::set(this, "usb_agt*", "usb_cfg", env_cfg.usb_cfg);

      // Finally, create the Agent. Do this after the DB calls to show they are separate
      agt = usb_agent::type_id::create("usb_agt", this);

      if (env_cfg.enable_coverage)
        cov = usb_cov_collect::type_id::create("cov", this);
   endfunction

endclass
