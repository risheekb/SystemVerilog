/***********************************************************************
 * Testbench top for "dual-top" example
 * Compile with compile_dual.bat or compile_dual.do
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

module instr_reg(output logic [7:0] q,
		 input  logic clk, load_en, reset_n,
		 input  logic [7:0] d);

  always_ff @(posedge clk or negedge reset_n) begin
    if (!reset_n)
      q <= '0;
    else
      q <= d;
  end

endmodule
