/***********************************************************************
 * Sequence for TX UVM example
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

class tx_vseq extends uvm_sequence;
  `uvm_object_utils(tx_vseq)
  function new(string name="tx_vseq");
    super.new(name);
  endfunction

  tx_env_config env_cfg;

  virtual tx_interface vif;

  semaphore key = new(1); // Synchronizes the left and right sequences

  virtual task body();
    tx_seq_left left;
    tx_seq_right right;

    left = tx_seq_left::type_id::create("left");
    right = tx_seq_right::type_id::create("right");

    assert(env_cfg != null);
    assert(env_cfg.agt_cfg != null);
    assert(env_cfg.agt_cfg.sqr != null);
    fork
      left.start(env_cfg.agt_cfg.sqr, this);  // Pass in "this" to access flag
      right.start(env_cfg.agt_cfg.sqr, this);
    join
  endtask

  task init_start(input tx_env_config env_cfg);
    this.env_cfg = env_cfg;
    vif = env_cfg.agt_cfg.vif;
    start(null);
  endtask
  
endclass
