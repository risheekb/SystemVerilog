/************************************************************************\
|*                                                                      *|
|*    Copyright (c) 2008  Ashok B.Mehta. All rights reserved.           *|
|*                                                                      *|
|*  This example code should be used only for illustration purpose      *|
|*  This material is not to be reproduced,  copied,  or used  in any    *|
|*  manner without the authorization of the author's written permission *|
|*                                                                      *|
|*  Author: Ashok B. Mehta  (Email:ashok@defineview.com)                *|
\************************************************************************/

module counter_property (
  input clk, rst_, ld_cnt_, updn_cnt, count_enb,
  input [7:0] data_in,
  input logic [7:0] data_out
  );

//------------------------------------

//        CHECK # 1. Check that when 'rst_' is asserted (==0) that data_out == 8'b0

//------------------------------------
`ifdef check1
property counter_reset;
  @(clk) disable iff (rst_) !rst_ |=> (data_out == 8'b0);
endproperty

counter_reset_check: assert property(counter_reset) 
  else $display($stime,,,"\t\tCOUNTER RESET CHECK FAIL:: rst_=%b data_out=%0d \n",
				rst_,data_out);
`endif

//------------------------------------

//        CHECK # 2. Check that if ld_cnt_ is deasserted (==1) and count_enb is not enabled
//                   (==0) that data_out HOLDS it's previous value.
//                   Disable this property 'iff (!rst)'

//------------------------------------
`ifdef check2
property counter_hold;
  @(posedge clk) disable iff (!rst_) (ld_cnt_ & !count_enb) |=> data_out === $past(data_out);
endproperty

counter_hold_check: assert property(counter_hold) 
  else $display($stime,,,"\t\tCOUNTER HOLD CHECK FAIL:: counter HOLD \n");
`endif

//------------------------------------

//        CHECK # 3. Check that if ld_cnt_ is deasserted (==1) and count_enb is enabled
//                   (==1) that if updn_cnt==1 the count goes UP and
//                              if updn_cnt==0 the count goes DOWN.
//                   Disable this property 'iff (!rst)'

//------------------------------------

`ifdef check3
property counter_count;
  @(posedge clk) disable iff (!rst_) (ld_cnt_ & count_enb) |->
    if (updn_cnt) ##1 (data_out-8'h01) == $past(data_out)
    else          ##1 (data_out+8'h01) == $past(data_out);
endproperty

counter_count_check: assert property(counter_count) 
  else $display($stime,,,"\t\tCOUNTER COUNT CHECK FAIL:: UPDOWN COUNT using $past \n"); 
`endif

//------------------------------------
// Alternate way of writing assertion for CHECK # 3
// Check for count using local variable
//------------------------------------
/*
`ifdef check3
property counter_count_local;
logic[7:0] local_data;
  @(posedge clk) disable iff (!rst_) (ld_cnt_ & count_enb, local_data = data_out) |->
    if (updn_cnt) ##1 (data_out == (local_data+8'h01))
    else          ##1 (data_out == (local_data-8'h01));
endproperty

counter_count_check: assert property(counter_count_local) 
  else $display($stime,,,"\t\tCOUNTER COUNT CHECK FAIL:: UPDOWN COUNT using local var \n"); 

`endif
*/

endmodule
