/////////////////////////////////////////////////////////////////////
////                                                             ////
////  Author: Eyal Hochberg                                      ////
////          eyal@provartec.com                                 ////
////                                                             ////
////  Downloaded from: http://www.opencores.org                  ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2010 Provartec LTD                            ////
//// www.provartec.com                                           ////
//// info@provartec.com                                          ////
////                                                             ////
//// This source file may be used and distributed without        ////
//// restriction provided that this copyright statement is not   ////
//// removed from the file and that any derivative work contains ////
//// the original copyright notice and the associated disclaimer.////
////                                                             ////
//// This source file is free software; you can redistribute it  ////
//// and/or modify it under the terms of the GNU Lesser General  ////
//// Public License as published by the Free Software Foundation.////
////                                                             ////
//// This source is distributed in the hope that it will be      ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied  ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR     ////
//// PURPOSE.  See the GNU Lesser General Public License for more////
//// details. http://www.gnu.org/licenses/lgpl.html              ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
//---------------------------------------------------------
//-- File generated by RobustVerilog parser
//-- Version: 1.0
//-- Invoked Fri Mar 25 23:36:56 2011
//--
//-- Source file: dma_ch_outs.v
//---------------------------------------------------------



module dma_axi64_core0_ch_outs(clk,reset,cmd,clr,outs_max,outs,outs_empty,stall,timeout);
   
   input                    clk;
   input             reset;

   input             cmd;
   input             clr;
   input [`OUT_BITS-1:0]    outs_max;
   output [`OUT_BITS-1:0]   outs;
   output             outs_empty;
   output             stall;
   output             timeout;
   

   reg [`OUT_BITS-1:0]         outs;
   wire [`OUT_BITS-1:0]     outs_pre;
   reg                 stall;
   reg [`TIMEOUT_BITS-1:0]  counter;


   
   assign             outs_empty = outs == 'd0;
   
   assign             outs_pre = outs + cmd - clr;
   
   always @(posedge clk or posedge reset)
     if (reset)
       outs <= #1 'd0;
     else if (cmd | clr)
       outs <= #1 outs_pre;

   
   always @(posedge clk or posedge reset)
     if (reset)
       stall <= #1 1'b0;
     else if (|outs_max)
       stall <= #1 outs >= outs_max;
   

   
   assign             timeout = (counter == 'd0);
   
   always @(posedge clk or posedge reset)
     if (reset)
       counter <= #1 {`TIMEOUT_BITS{1'b1}};
     else if (clr)
       counter <= #1 {`TIMEOUT_BITS{1'b1}};
     else if (|outs)
       counter <= #1 counter - 1'b1;
   
             
endmodule
   










