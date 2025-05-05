/***********************************************************************
 * UVM environment class in ALU scoreboard example
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
// ALU environment for scoreboard plus predictor and evaluator

class alu_env extends uvm_env;
   `uvm_component_utils(alu_env);
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction

   alu_scoreboard scb;
   alu_agent agt;

   virtual function void build_phase(uvm_phase phase);
      scb = alu_scoreboard::type_id::create("scb", this);
      agt = alu_agent::type_id::create("agt", this);
   endfunction

   virtual function void connect_phase(uvm_phase phase);
      agt.dut_in_port.connect(scb.dut_in_export);
      agt.dut_out_port.connect(scb.dut_out_export);
   endfunction
endclass : alu_env
