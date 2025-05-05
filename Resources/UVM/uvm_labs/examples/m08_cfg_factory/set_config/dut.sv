/***********************************************************************
 * DUT for "USB" UVM example
 * The DUT is an 8 bit FF
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

module dut(input logic        clk,
	   input logic 	      reset_n,
	   input logic  [7:0] d,
	   output logic [7:0] q);

  int force_error=0;
  initial begin
    if ($test$plusargs("FORCE_ERROR")) begin
      if (! $value$plusargs("FORCE_ERROR=%d", force_error))
        $error("+FORCE_ERROR=n must have a value - the cycle to cause error");
    end
  end

//   initial $monitor("@%t DUT: clk=%b, rst=%b, d=%d., q=%d.", $time, clk, reset_n, d, q);

   always_ff @(posedge clk or negedge reset_n) begin
      if (reset_n === 1'b0)
	q <= 0;
      else begin
        if (--force_error == 0) begin
          $display("\n****************\nForcing error\n****************\n");
          q <= ~d;
        end
        else
          q <= d;
      end
   end

endmodule : dut
