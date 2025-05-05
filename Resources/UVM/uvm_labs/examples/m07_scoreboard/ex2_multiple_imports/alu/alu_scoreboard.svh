/***********************************************************************
 * UVM Scoreboard for ALU with two analysis imports for ALU scoreboard example
 * Includes a predictor and evaluator
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

`uvm_analysis_imp_decl(_predictor)
`uvm_analysis_imp_decl(_evaluator)

class alu_scoreboard extends uvm_scoreboard;
   `uvm_component_utils(alu_scoreboard)
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction

   uvm_analysis_imp_predictor #(alu_txn, alu_scoreboard) dut_in_export;
   uvm_analysis_imp_evaluator #(alu_txn, alu_scoreboard) dut_out_export;

   alu_txn expect_a[bit [4:0]];

  int match, mismatch;

  virtual function void build_phase(uvm_phase phase);
    dut_in_export  = new("dut_in_export", this);
    dut_out_export = new("dut_out_export", this);
  endfunction

  virtual function void write_predictor(alu_txn t);
      alu_txn exp_txn;
      `uvm_info("PREDICTOR_IN", t.sprint(), UVM_FULL)
      if (!$cast(exp_txn, t.clone()))
        `uvm_fatal(get_type_name(), "Clone returned incorrect type")

      // Predict results from t, save in a alu_txn object
      case(t.opcode)
	ADD:   exp_txn.result = t.a + t.b;
	SUB:   exp_txn.result = t.a - t.b;
	PASSA: exp_txn.result = t.a;
	PASSB: exp_txn.result = t.b;
	NEGA:  exp_txn.result = 0 - t.a;
	default: `uvm_error("BADOPC", $sformatf("BAD opcode=%s (0x%x)", t.opcode.name(), t.opcode))
      endcase

     `uvm_info("PREDICTOR_OUT", exp_txn.sprint(), UVM_FULL)
      expect_a[t.addr] = exp_txn; // Save handle
  endfunction: write_predictor


  virtual function void write_evaluator(alu_txn t);
     `uvm_info("EVALUATOR", t.sprint(), UVM_MEDIUM)
    if ( !expect_a.exists(t.addr) )
      `uvm_error("SCB", $sformatf("Reading from addr not previously written: %h", t.addr))
    else if (t.compare(expect_a[t.addr])) begin
      match++;
      expect_a.delete(t.addr);
    end
    else begin
      // mismatch
      `uvm_error(get_type_name(), $sformatf("Mismatch at: %h", t.addr))
      `uvm_info(get_type_name(), 
		$sformatf("Transactions:\n\tDUT OUT=%s\n\tEXPECT=%s", t.sprint(), expect_a[t.addr].sprint()), UVM_MEDIUM)
      mismatch++;
      expect_a.delete(t.addr);
    end
  endfunction: write_evaluator

  virtual function void report_phase(uvm_phase phase);
    `uvm_info("SCB", $sformatf("Passed=%0d, failed=%0d", match, mismatch), UVM_LOW)
  endfunction: report_phase

endclass : alu_scoreboard
