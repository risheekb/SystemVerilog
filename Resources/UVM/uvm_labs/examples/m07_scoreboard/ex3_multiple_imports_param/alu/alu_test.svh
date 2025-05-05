/***********************************************************************
 * UVM test class for the ALU scoreboard example
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

class alu_test extends uvm_test;
   `uvm_component_utils(alu_test);
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction

   alu_env env;
   alu_config alu_cfg;

   virtual function void build_phase(uvm_phase phase);
      alu_cfg = alu_config::type_id::create("alu_cfg");
      if (!uvm_config_db#(virtual alu_ifc)::get(this, "", "vif", alu_cfg.vif))
	`uvm_fatal("NOVIF", "No virtual interface passed into test")
      uvm_config_db#(alu_config)::set(this, "env*", "alu_cfg", alu_cfg);

      env = alu_env::type_id::create("env", this);
   endfunction

  virtual task run_phase(uvm_phase phase);
     alu_sequence seq;

     phase.phase_done.set_drain_time(this, 20); // delay objection drop 20ns
     seq = alu_sequence::type_id::create("seq");
     phase.raise_objection(this, "Start alu_sequence");
     seq.start(env.agt.sqr);
     phase.drop_objection(this, "End alu_sequence");
  endtask

endclass : alu_test
