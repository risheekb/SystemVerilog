/***********************************************************************
 * Predictor for ALU scoreboard example
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

class alu_predictor extends uvm_subscriber #(alu_txn);
   `uvm_component_utils(alu_predictor)
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction

  // add a port to send out the predicted result
  uvm_analysis_port #(alu_txn) expect_port;

  virtual function void build_phase(uvm_phase phase);
    expect_port = new("expect_port", this);
  endfunction

  virtual function void write(alu_txn t);
    alu_txn exp_txn;

    if (!$cast(exp_txn, t.clone())) 
      `uvm_fatal(get_type_name(), "Clone returned incorrect type")
    case(exp_txn.opcode)
      ADD:   exp_txn.result = exp_txn.a + exp_txn.b;
      SUB:   exp_txn.result = exp_txn.a - exp_txn.b;
      PASSA: exp_txn.result = exp_txn.a;
      PASSB: exp_txn.result = exp_txn.b;
      NEGA:  exp_txn.result = 0 - exp_txn.a;
      default: `uvm_warning(get_type_name(), $sformatf("Unrecognized opcode=0x%x", exp_txn.opcode))
    endcase

     `uvm_info("PREDICTOR", exp_txn.sprint(), UVM_FULL)
    expect_port.write(exp_txn);
  endfunction: write
endclass : alu_predictor
