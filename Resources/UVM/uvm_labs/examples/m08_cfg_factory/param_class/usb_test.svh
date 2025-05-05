/***********************************************************************
 * Test for UVM configuration flow example
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

class usb_test extends uvm_test;
   `uvm_component_utils(usb_test);
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction

   usb_env #(usb_agent) env;
   usb_config usb_cfg;
   env_config env_cfg;

   virtual function void build_phase(uvm_phase phase);

      // Create the tree of configuration objects, and store in DB
      env_cfg = env_config::type_id::create("env_cfg");
      usb_cfg = usb_config::type_id::create("usb_cfg");
      env_cfg.usb_cfg = usb_cfg;
      uvm_config_db #(env_config)::set(this, "env", "env_cfg", env_cfg);

      // Fill in the configuration
      if (! uvm_config_db#(virtual usb_interface)::get(this, "", "vif", usb_cfg.vif))
	`uvm_fatal("NOVIF", "No USB VIF in DB");

      // Let the user override addr from the command line
      usb_cfg.addr = 66; // Override the default
      void'(uvm_config_db#(uvm_bitstream_t)::get(this, "", "addr", usb_cfg.addr));
      `uvm_info(get_type_name(), $sformatf("addr=%0x", usb_cfg.addr), UVM_LOW) // Should be UVM_FULL

      // Finally, create the environment. Do this after the DB calls to show they are separate
      env = usb_env#(usb_agent)::type_id::create("env", this);
   endfunction

   virtual function void end_of_elaboration_phase(uvm_phase phase);
      `uvm_info("TEST_TOPO", "Printing topology from end_of_elaboration_phase", UVM_NONE);
      uvm_top.print_topology();
   endfunction

   virtual task run_phase(uvm_phase phase);
      usb_sequence seq;
      `uvm_info("RUN", $sformatf("In %m"), UVM_FULL);

      // Wait for last transaction to pass through the design
      phase.phase_done.set_drain_time(this, 20); // Delay the objection drop for 20ns

      phase.raise_objection(this, get_type_name());
      seq = usb_sequence::type_id::create("seq");
      seq.start(env.agt.sqr);
      phase.drop_objection(this, get_type_name());
   endtask

endclass
