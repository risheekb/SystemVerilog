/***********************************************************************
 * UVM agent class for the ALU scoreboard example
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

class alu_agent extends uvm_agent;
   `uvm_component_utils(alu_agent)
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction

   alu_driver drv;
   alu_monitor mon;
   uvm_sequencer #(alu_txn) sqr;
   uvm_analysis_port #(alu_txn) dut_in_port;
   uvm_analysis_port #(alu_txn) dut_out_port;

   virtual function void build_phase(uvm_phase phase);
      drv = alu_driver::type_id::create("drv",this);
      mon = alu_monitor::type_id::create("mon",this);
      sqr = uvm_sequencer #(alu_txn)::type_id::create("sqr",this);
      dut_in_port = new("dut_in_port", this);
      dut_out_port = new("dut_out_port", this);
   endfunction

   virtual function void connect_phase(uvm_phase phase);
      drv.seq_item_port.connect(sqr.seq_item_export);
      mon.dut_in_tx_port.connect(dut_in_port);
      mon.dut_out_tx_port.connect(dut_out_port);
   endfunction
endclass : alu_agent
