/***********************************************************************
 * Definitions for the AHB model and blocks that connect to it
 * Nothing directly testbench related
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

package ahb_pkg;

  parameter int AHB_ADDR_WIDTH = 32;
  parameter int AHB_DATA_WIDTH = 32;

  typedef bit   [AHB_DATA_WIDTH-1:0] AHB_DATA2_T;
  typedef logic [AHB_DATA_WIDTH-1:0] AHB_DATA4_T;
  typedef bit   [AHB_ADDR_WIDTH-1:0] AHB_ADDR2_T;
  typedef logic [AHB_ADDR_WIDTH-1:0] AHB_ADDR4_T;
endpackage : ahb_pkg
