/***********************************************************************
 * Sequence for UVM override example
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

class tx_vseq extends uvm_sequence #(tx_item);
  `uvm_object_utils(tx_vseq)
  function new(string name="tx_vseq");
    super.new(name);
  endfunction

  tx_env_config env_cfg;

  task init_start(input tx_env_config env_cfg);
    this.env_cfg = env_cfg;
    this.start(null);
  endtask


  // Start a separate sequence on each agent
  virtual task body();
    tx_sequence seq[NUM_TX_AGT];

    // Start a separate instance of the sequence on each agent

/*  Start sequences sequentially - less desireable
     foreach (seq[i]) begin
	seq[i] = tx_sequence::type_id::create($sformatf("seq%0d", i));
	seq[i].start(env_cfg.tx_cfg[i].sqr);
      end
*/

/*  Start sequences in parallel with fork-join_none
*/
    foreach (seq[j])
      fork
	int i = j;
	begin
	  seq[i] = tx_sequence::type_id::create($sformatf("seq%0d", i));
	  seq[i].start(env_cfg.tx_cfg[i].sqr);
	end
      join_none

    // Wait for all child threads to complete
    wait fork;
  endtask

endclass : tx_vseq
