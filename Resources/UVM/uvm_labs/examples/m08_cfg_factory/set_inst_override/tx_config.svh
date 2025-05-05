/***********************************************************************
 * Agent configuration for UVM override example
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

class tx_config extends uvm_object;

  `uvm_object_utils(tx_config)
  function new(string name="tx_config");
    super.new(name);
  endfunction

  // Virtual interface
  virtual tx_interface vif;

  // Is the agent active or passive?
  uvm_active_passive_enum active = UVM_ACTIVE;

  // Sequencer handle, set by agent, read by test or virtual sequence
  tx_sequencer sqr;

endclass
