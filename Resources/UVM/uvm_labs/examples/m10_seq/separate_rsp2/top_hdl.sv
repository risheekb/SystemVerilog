/***********************************************************************
 * Top of the Design Under Test for example of configuring a sequence
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

module top_hdl();
  timeunit 1ns; timeprecision 1ns;

  import test_params_pkg::*;

  ahb_ifc ahb_if();
  ahb_slave_mem #(.ADDR_LO(SLAVE_0_ADDR_LO),
		  .ADDR_HI(SLAVE_0_ADDR_HI),
		  .ID(0))
  slv_mem0 (ahb_if);

endmodule : top_hdl
