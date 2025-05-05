/***********************************************************************
 * Interface to connect to AHB DUT
 *
 * Provides send() and get*() methods for testbench
 * Methods are NOT reentrant and so are NOT declared automatic
 * Methods have semaphore to check if called concurrently, then $fatal
 *
 * Future improvements:
 * - Transfer struct instead of handle, for emulation
 * - Create BFM style, for emulation
 *
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

interface ahb_ifc();
  timeunit 1ns; timeprecision 1ns;

  import ahb_test_pkg::*;

  tri0 hready;
  logic hready_bfm; // Driven by BFM

  logic hresp, hwrite, hmastlock, hclk, hresetn;
  logic [1:0] htrans;
  logic [2:0] hsize, hburst;
  logic [3:0] hprot;
  AHB_ADDR4_T haddr;
  AHB_DATA4_T hrdata, hwdata;

  assign hready = hready_bfm;


  initial begin
//DBG    $monitor("@%t MON: hresetn=%b, hclk=%b, haddr=%0x, hwrite=%b, hrdata=%0x, hwdata=%0x, hready=%b, hready_bfm=%b", $realtime, hresetn, hclk, haddr, hwrite, hrdata, hwdata, hready, hready_bfm);
    #10ns;		// 10ns
    hresetn = 0;	// negedge hresetn
    hready_bfm = 'z;

    #10ns;		// 20ns
    hclk = 0;		// After reset, start with posedge to send()

    #10ns;		// 30ns
    hresetn = '1;

    #10ns;		// 40ns
    forever		// 50ns First posedge hclk
      #10ns hclk = !hclk;
  end


  // Drive a transaction out on negedge hclk. Assume no wait states, no overlap
  task automatic send(ahb_txn t);

    wait (hresetn===1);
    @(negedge hclk);
//DBG    $display("@%t %m after @(negedge hclk): t=%s", $realtime, t.sprint());

    case (t.opcode)
      AHB_WRITE: begin
	haddr      = t.addr;
	hwrite     = 1;
	hready_bfm = 1;

	@(negedge hclk);
	haddr      = 'z;
	hwrite     = 'z;
	hwdata     = t.data;
	hready_bfm = 1;

	@(negedge hclk);
	hwdata     = 'z;
	hready_bfm = 'z;
      end

      AHB_READ:	begin
	haddr      = t.addr;
	hwrite     = 0;
	hready_bfm = 1;

	@(negedge hclk);
	haddr      = 'z;
	hwrite     = 'z;
	hready_bfm = 'z;

	do
	@(posedge hclk);
	while (hready !== 1);

	t.data = hrdata;
      end

      default:
	$fatal(0, "Unrecognized AHB opcode %s (0x%0x)", t.opcode.name(), t.opcode);
    endcase

//DBG    $display("@%t %m final:, t=%s", $realtime, t.sprint());
  endtask


  // Block and get the next input transaction
  task automatic get_an_input(ahb_txn t);
    logic hwrite_sample;

    wait (hresetn===1);

    // Address phase
    do
      @(negedge hclk) #1ns;
    while (hready !== 1);
//DBG    $display("@%t %m: address phase", $realtime);
    hwrite_sample = hwrite;
    t.addr = haddr;
    t.opcode = (hwrite === 1) ? AHB_WRITE : AHB_READ;

    // Data phase
    do
      @(negedge hclk) #1ns;
    while (hready !== 1);

//DBG    $display("@%t %m: data phase", $realtime);
    t.data = (hwrite_sample===1) ? hwdata : hrdata;
//DBG    $display("@%t %m: t=%s", $realtime, t.sprint());

  endtask


  task automatic get_an_output(ahb_txn t);
    logic hwrite_sample;

    wait (hresetn===1);

    // Address phase
    do
      @(posedge hclk);
    while (hready !== 1);
    hwrite_sample = hwrite;
    t.addr = haddr;
    t.opcode = (hwrite_sample === 1) ? AHB_WRITE : AHB_READ;

    // Data phase
    do
      @(posedge hclk);
    while (hready !== 1);
    t.data = (hwrite_sample===1) ? hwdata : hrdata;
    t.result = (hwrite_sample===1) ? hwdata : hrdata;
//DBG    $display("@%t %m: t=%s", $realtime, t.sprint());

  endtask

endinterface : ahb_ifc
