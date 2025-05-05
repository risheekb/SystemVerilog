/***********************************************************************
 * AHB environment for scoreboard plus predictor and evaluator
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

class ahb_env extends uvm_env;
  `uvm_component_utils(ahb_env);
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  ahb_predictor predict;
  ahb_scoreboard scb;
  ahb_agent agt;
//  ahb_config ahb_cfg; // Not needed here

  virtual function void build_phase(uvm_phase phase);
    // if (! uvm_config_db#(ahb_config)::get(this, "", "ahb_cfg", ahb_cfg))
    //   `uvm_fatal("NO", "AHB_CFG")

    predict = ahb_predictor::type_id::create("predict", this);
    scb = ahb_scoreboard::type_id::create("scb", this);
    agt = ahb_agent::type_id::create("agt", this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    agt.dut_in_port.connect(predict.analysis_export);
    predict.expected_port.connect(scb.dut_in_export);
    agt.dut_out_port.connect(scb.dut_out_export);
  endfunction
endclass : ahb_env
