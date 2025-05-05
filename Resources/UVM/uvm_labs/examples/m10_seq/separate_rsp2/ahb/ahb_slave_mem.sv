/***********************************************************************
 * AHB Slave: Design Under Test
 * Simple memory, variable address range
 * Very simple AHB with a single master and single slave
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


module ahb_slave_mem
  import ahb_pkg::*;
  #(parameter bit [31:0] ADDR_LO = 0, ADDR_HI = 32'hFFFF, ID=0)
  (ahb_ifc ifc);

  timeunit 1ns; timeprecision 1ns;

  localparam AHB_ADDR2_T ADDR_SIZE = ADDR_HI - ADDR_LO;

  AHB_DATA4_T memory[ADDR_SIZE];
  AHB_ADDR4_T addr_in = 0, idx;
  logic hready = 'z;
  assign ifc.hready = hready;


  // Print configuration
  initial #0 $display("@%t %m configuration: ADDR_LO=0x%0x, ADDR_HI=0x%0x, ID=%0x", $realtime, ADDR_LO, ADDR_HI, ID);

  // Decode transactions
  always @(ifc.hclk, negedge ifc.hresetn) begin

    if (ifc.hresetn === 1) begin : HCLK

      if (ifc.hclk === 1) begin : PCLK
	if (ifc.hready === 1) begin : READY

	  // Start operation: Address phase
	  if (ifc.haddr inside {[ADDR_LO : ADDR_HI]}) begin : ADDR
	    addr_in = ifc.haddr;     // Sample address
	    idx = addr_in - ADDR_LO;

	    if (ifc.hwrite === 1) begin : WRITE
	      @(posedge ifc.hclk);	// Move to start of data cycle
	      while (ifc.hready !== 1)
		@(posedge ifc.hclk);	// Sample point at end of data cycle
	      memory[idx] = ifc.hwdata;
	      $display("@%t AHB_MEM%0d WR: mem[%0x] = %0x (addr_in=%0x, ADDR_LO=%0x)",
		       $realtime, ID, idx, memory[idx], addr_in, ADDR_LO);
	    end : WRITE

	    else if (ifc.hwrite === 0) begin : READ
	      #1ns;			// Move to start of data cycle
	      hready <= 1;
	      @(negedge ifc.hclk) #1ns;
	      ifc.hrdata <= memory[idx];
	      $display("@%t AHB_MEM%0d RD: %0x = mem[%0x] (addr_in=%0x, ADDR_LO=%0x)",
		       $realtime, ID, memory[idx], idx, addr_in, ADDR_LO);
	      @(posedge ifc.hclk) #1ns;
	      ifc.hrdata <= 'z;
	      hready <= 'z;
	    end : READ
	  end : ADDR
	end : READY
      end : PCLK
    end : HCLK

    else begin : RST
      hready <= 'z;
      ifc.hrdata <= 'z;
    end : RST
  end // always

endmodule : ahb_slave_mem
