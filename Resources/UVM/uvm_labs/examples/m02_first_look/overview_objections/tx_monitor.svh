/***********************************************************************
 * Monitor for TX UVM example
 * This is trivial as there is no DUT, so nothing to monitor
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

class tx_monitor extends uvm_monitor;
  `uvm_component_utils(tx_monitor);
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    //      `uvm_info("BUILD", $sformatf("In %m"), UVM_LOW);
  endfunction

  virtual task run_phase(uvm_phase phase);
    //      `uvm_info("RUN", $sformatf("In %m"), UVM_LOW);
  endtask
endclass
