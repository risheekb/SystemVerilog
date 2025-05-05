/***********************************************************************
 * Package for TX UVM example
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

package tx_pkg;
  import uvm_pkg::*;
`include "uvm_macros.svh"
  typedef class tx_agent_config;
  typedef class tx_env_config;

`include "tx_item.svh"
`include "tx_sequence.svh"
`include "tx_monitor.svh"
`include "tx_driver.svh"
`include "tx_agent_config.svh"
`include "tx_agent.svh"
`include "tx_env_config.svh"
`include "tx_env.svh"
`include "tx_test.svh"

endpackage : tx_pkg
