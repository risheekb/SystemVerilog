/***********************************************************************
 * Combined AHB agent and env config object for example of configuring a sequence
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


class ahb_config extends uvm_object;
  `uvm_object_utils(ahb_config)
  function new(string name="ahb_config");
    super.new(name);
  endfunction

  virtual ahb_ifc vif;

  uvm_active_passive_enum active;

  // Test just one slave memory
  // Address range
  AHB_ADDR2_T addr_lo, addr_hi, id;

  // Number of transactions to generate
  int 	  n_trans;

  // Sequencer for the one agent
  uvm_sequencer #(ahb_txn) sqr;

endclass : ahb_config
