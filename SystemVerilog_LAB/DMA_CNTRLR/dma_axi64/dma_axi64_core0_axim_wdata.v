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
//-- Invoked Fri Mar 25 23:36:54 2011
//--
//-- Source file: dma_core_axim_wdata.v
//---------------------------------------------------------



module dma_axi64_core0_axim_wdata(clk,reset,rd_transfer,rd_transfer_size,ch_fifo_rd,ch_fifo_rsize,ch_fifo_rdata,ch_fifo_rd_valid,ch_fifo_wr_ready,ch_fifo_rd_num,wr_transfer_num,wr_transfer,wr_transfer_size,wr_next_size,wr_resp_full,wr_cmd_full,wr_clr_line,wr_clr_line_num,joint_stall,axim_timeout_num,axim_timeout,AWID,AWADDR,AWLEN,AWSIZE,AWVALID,AWREADY,AJOINT,WDATA,WSTRB,WLAST,WVALID,WREADY);

   input               clk;
   input               reset;

   input               rd_transfer;
   input [4-1:0]      rd_transfer_size;
   output               ch_fifo_rd;
   output [4-1:0]     ch_fifo_rsize;
   input [64-1:0]      ch_fifo_rdata;
   input               ch_fifo_rd_valid;
   input               ch_fifo_wr_ready;
   output [2:0]           ch_fifo_rd_num;
   output [2:0]           wr_transfer_num;
   output               wr_transfer;
   output [4-1:0]     wr_transfer_size;
   output [4-1:0]     wr_next_size;

   input               wr_resp_full;
   output               wr_cmd_full;
   output               wr_clr_line;
   output [2:0]           wr_clr_line_num;

   output               joint_stall;
   
   output [2:0]           axim_timeout_num;
   output               axim_timeout;
   
   
   input [`CMD_BITS-1:0]       AWID;
   input [32-1:0]      AWADDR;
   input [`LEN_BITS-1:0]      AWLEN;
   input [1:0]               AWSIZE;
   input               AWVALID;
   input               AWREADY;
   input               AJOINT;
   
   output [64-1:0]     WDATA;
   output [8-1:0]     WSTRB;
   output               WLAST;
   output               WVALID;
   input               WREADY;

   
   wire [`CMD_BITS-1:0]       WID;
   wire [`CMD_BITS-1:0]       WID_pre;
   reg [8-1:0]           WSTRB_pre;
   wire [1:0]               WSIZE_pre;
   wire [`LEN_BITS-1:0]       WLEN_pre;
   
   wire [`CMD_BITS-1:0]       WID_data;
   wire [8-1:0]       WSTRB_data;
   wire [1:0]               WSIZE_data;
   wire [`LEN_BITS-1:0]       WLEN_data;
   wire               WVALID;
   wire               WLAST;
   wire               valid_last;
   wire               wr_clr_line_stall_pre;
   wire               wr_clr_line_stall;
   wire               wr_clr_line_pre;
   reg [2:0]               wr_clr_line_num;
   wire [2:0]               wr_transfer_num_pre;
   wire               wr_transfer_pre;
   wire [4-1:0]       wr_transfer_size_pre;
   reg [2:0]               wr_transfer_num;
   wire               wr_transfer;
   reg [4-1:0]           wr_transfer_size;
      
   reg [2:0]               last_channel;
   
   wire [`CMD_BITS-1:0]       WID_cmd;
   wire [1:0]               WSIZE_cmd;   
   reg [4-1:0]           wr_next_size;
   wire [`LEN_BITS-1:0]       WLEN_cmd;

   wire               data_ready;
   wire [2:0]               data_fullness_pre;
   reg [2:0]               data_fullness;
   wire               joint_fifo_rd_valid;
   wire               joint_req_out;
   wire               joint_stall;
   wire               rd_transfer_joint;
   wire [4-1:0]       rd_transfer_size_joint;
   wire               rd_transfer_full;
   
   wire               cmd_push;
   wire               cmd_pop;
   wire               cmd_pop_d;
   wire               cmd_empty;
   wire               cmd_full;
   
   wire               cmd_data_push;
   wire               cmd_data_pop;
   wire               cmd_data_empty;
   wire               cmd_data_full;
   
   wire               data_push;
   wire               data_pop;
   wire               data_empty;
   wire               data_full;
   
   reg [`LEN_BITS-1:0]           rd_out_count;
   reg [`LEN_BITS-1:0]           rd_in_count;

   wire               data_pending_pre;
   wire               data_pending;
   wire               line_end;
   wire [2:0]               line_end_num;
   

   //joint
   assign               data_ready        = ch_fifo_rd_valid;
   assign               data_fullness_pre = data_fullness + data_ready - wr_transfer_pre;
   
   always @(posedge clk or posedge reset)
     if (reset)
       data_fullness <= #1 3'd0;
     else if (data_ready | wr_transfer_pre)
       data_fullness <= #1 data_fullness_pre;

   prgen_joint_stall #(4)
     gen_joint_stall (
              .clk(clk),
              .reset(reset),
              .joint_req_out(joint_req_out),
              .rd_transfer(rd_transfer),
              .rd_transfer_size(rd_transfer_size),
              .ch_fifo_rd(ch_fifo_rd),
              .data_fullness_pre(data_fullness_pre),
              .HOLD(1'b0),
              .joint_fifo_rd_valid(joint_fifo_rd_valid),
              .rd_transfer_size_joint(rd_transfer_size_joint),
              .rd_transfer_full(rd_transfer_full),
              .joint_stall(joint_stall)
              );

   
   
   //fifo rd command
   assign               data_pending_pre = WVALID & (~WREADY);

   prgen_delay #(1) delay_pending (.clk(clk), .reset(reset), .din(data_pending_pre), .dout(data_pending));
 
  //assign                   wr_next_size  = 1'b1 << WSIZE_cmd;
   always @(/*AUTOSENSE*/WSIZE_cmd)
     begin
        case (WSIZE_cmd)
          2'b00 : wr_next_size = 4'd1;
          2'b01 : wr_next_size = 4'd2;
          2'b10 : wr_next_size = 4'd4;
          2'b11 : wr_next_size = 4'd8;
        endcase
     end

   assign               ch_fifo_rd = 
                  joint_fifo_rd_valid |
                  
                  ((~cmd_empty) & 
                  (~data_pending) &
                  (~wr_clr_line_stall) &
                  ch_fifo_wr_ready);
   
   
   assign               ch_fifo_rsize =
                  joint_fifo_rd_valid ? rd_transfer_size_joint :
                  WID_cmd[5:4] == 2'b00 ? 4'd1 :
                  WID_cmd[5:4] == 2'b01 ? 4'd2 :
                  WID_cmd[5:4] == 2'b10 ? 4'd4 : 4'd8;
   
   assign               ch_fifo_rd_num   =  WID_cmd[2:0];

   
   prgen_delay #(1) delay_cmd_pop (.clk(clk), .reset(reset), .din(cmd_pop), .dout(cmd_pop_d));
   
   always @(posedge clk or posedge reset)
     if (reset)
       last_channel <= #1 3'b000;
     else if (cmd_push)
       last_channel <= #1 WID_pre[2:0];
      
   
   //update pointers in channel
   assign               wr_transfer_num_pre  = WID_data[2:0];
   
   assign               wr_transfer_pre      = WVALID & WREADY;
   
   assign               wr_transfer_size_pre =
                  WID_data[5:4] == 2'b00 ? 4'd1 :
                  WID_data[5:4] == 2'b01 ? 4'd2 :
                  WID_data[5:4] == 2'b10 ? 4'd4 : 4'd8;
   
   prgen_delay #(1) delay_wr_transfer (.clk(clk), .reset(reset), .din(wr_transfer_pre), .dout(wr_transfer));
   
   always @(posedge clk or posedge reset)
     if (reset)
       begin
      wr_transfer_num  <= #1 3'd0;
      wr_transfer_size <= #1 3'd0;
       end
     else if (wr_transfer_pre)
       begin
      wr_transfer_num  <= #1 wr_transfer_num_pre;
      wr_transfer_size <= #1 wr_transfer_size_pre;
       end
   
   
   assign               valid_last      = ch_fifo_rd & (rd_out_count == WLEN_cmd) & (~cmd_empty);
      
   assign               wr_clr_line_pre = valid_last & line_end;
   
   always @(posedge clk or posedge reset)
     if (reset)
       wr_clr_line_num <= #1 3'd0;
     else if (wr_clr_line_pre)
       wr_clr_line_num <= #1 line_end_num;

   assign wr_clr_line_stall_pre = wr_clr_line_pre & (ch_fifo_rd_num == line_end_num);

   prgen_delay #(1) delay_stall (.clk(clk), .reset(reset), .din(wr_clr_line_stall_pre), .dout(wr_clr_line_stall));

   prgen_delay #(2) delay_clr_line (.clk(clk), .reset(reset), .din(wr_clr_line_pre), .dout(wr_clr_line));
   
   
   //command phase
   assign               wr_cmd_full = cmd_full | cmd_data_full | wr_resp_full;

   assign               cmd_push = AWVALID & AWREADY;
   assign               cmd_pop  = valid_last;
   
   assign               WID_pre   = AWID;
   assign               WLEN_pre  = AWLEN;
   assign               WSIZE_pre = AWSIZE;


   //always @(/*AUTOSENSE*/ - no AUTOSENSE due to defines
   always @(AWADDR or AWSIZE)
     begin              
    case ({AWSIZE[1:0], AWADDR[2:0]})
      //8 bit
      {2'b00, 3'b000} : WSTRB_pre = 8'b0000_0001;
      {2'b00, 3'b001} : WSTRB_pre = 8'b0000_0010;
      {2'b00, 3'b010} : WSTRB_pre = 8'b0000_0100;
      {2'b00, 3'b011} : WSTRB_pre = 8'b0000_1000;
      {2'b00, 3'b100} : WSTRB_pre = 8'b0001_0000;
      {2'b00, 3'b101} : WSTRB_pre = 8'b0010_0000;
      {2'b00, 3'b110} : WSTRB_pre = 8'b0100_0000;
      {2'b00, 3'b111} : WSTRB_pre = 8'b1000_0000;

      //16 bit
      {2'b01, 3'b000} : WSTRB_pre = 8'b0000_0011;
      {2'b01, 3'b001} : WSTRB_pre = 8'b0000_0011;
      {2'b01, 3'b010} : WSTRB_pre = 8'b0000_1100;
      {2'b01, 3'b011} : WSTRB_pre = 8'b0000_1100;
      {2'b01, 3'b100} : WSTRB_pre = 8'b0011_0000;
      {2'b01, 3'b101} : WSTRB_pre = 8'b0011_0000;
      {2'b01, 3'b110} : WSTRB_pre = 8'b1100_0000;
      {2'b01, 3'b111} : WSTRB_pre = 8'b1100_0000;

      //32 bit
      {2'b10, 3'b000} : WSTRB_pre = 8'b0000_1111;
      {2'b10, 3'b001} : WSTRB_pre = 8'b0000_1111;
      {2'b10, 3'b010} : WSTRB_pre = 8'b0000_1111;
      {2'b10, 3'b011} : WSTRB_pre = 8'b0000_1111;
      {2'b10, 3'b100} : WSTRB_pre = 8'b1111_0000;
      {2'b10, 3'b101} : WSTRB_pre = 8'b1111_0000;
      {2'b10, 3'b110} : WSTRB_pre = 8'b1111_0000;
      {2'b10, 3'b111} : WSTRB_pre = 8'b1111_0000;

      //64 bit
      default : WSTRB_pre = 8'b1111_1111;
    endcase
     end

   
   prgen_fifo #(`CMD_BITS+`LEN_BITS+2+1, 4) 
   cmd_fifo(
        .clk(clk),
        .reset(reset),
        .push(cmd_push),
        .pop(cmd_pop),
        .din({WID_pre,  
          WSIZE_pre,
          WLEN_pre,
          AJOINT
          }
         ),
        .dout({WID_cmd,
           WSIZE_cmd,
           WLEN_cmd,
           joint_req_out
           }
          ),
        .empty(cmd_empty),
        .full(cmd_full)
        );


   assign               line_end     = WID_cmd[6];
   assign               line_end_num = WID_cmd[2:0];
   
   always @(posedge clk or posedge reset)
     if (reset)
       rd_out_count <= #1 {`LEN_BITS{1'b0}};
     else if (cmd_pop)
       rd_out_count <= #1 {`LEN_BITS{1'b0}};
     else if (ch_fifo_rd)
       rd_out_count <= #1 rd_out_count + 1'b1;

   
   //data phase
   assign               cmd_data_push = cmd_push;
   assign               cmd_data_pop  = WVALID & WREADY & WLAST;

   assign               WSTRB = (rd_in_count[0] ? {WSTRB_data[3:0], WSTRB_data[7:4]} : WSTRB_data) & {8{WVALID}};
   
   assign               WID   = WID_data;
   

   
   prgen_fifo #(8+`LEN_BITS+`CMD_BITS+2, 4) 
   cmd_data_fifo(
         .clk(clk),
         .reset(reset),
         .push(cmd_data_push),
         .pop(cmd_data_pop),
         .din({WLEN_pre,
               WSIZE_pre,
               WSTRB_pre,
               WID_pre
               }),
         .dout({WLEN_data,
            WSIZE_data,
            WSTRB_data,
            WID_data
            }),
         .empty(cmd_data_empty),
         .full(cmd_data_full)
         );
   
   
   always @(posedge clk or posedge reset)
     if (reset)
       rd_in_count <= #1 {`LEN_BITS{1'b0}};
     else if (cmd_data_pop)
       rd_in_count <= #1 {`LEN_BITS{1'b0}};
     else if (wr_transfer_pre)
       rd_in_count <= #1 rd_in_count + 1'b1;


   
   //data fifo
   assign               data_push = ch_fifo_rd_valid;
   assign               data_pop  = wr_transfer_pre;

      
   //depth is set by maximum fifo read data latency
   prgen_fifo #(64, 5+2)
   data_fifo(
         .clk(clk),
         .reset(reset),
         .push(data_push),
         .pop(data_pop),
         .din(ch_fifo_rdata),
         .dout(WDATA),
         .empty(data_empty),
         .full(data_full)
         );
   
   assign               WVALID = ~data_empty;

   assign               WLAST  = WVALID & (rd_in_count == WLEN_data) & (~cmd_data_empty);


   
   dma_axi64_core0_axim_timeout  dma_axi64_axim_timeout (
                         .clk(clk),
                         .reset(reset),
                         .VALID(WVALID),
                         .READY(WREADY),
                         .ID(WID),
                         .axim_timeout_num(axim_timeout_num),
                         .axim_timeout(axim_timeout)
                         );
   
endmodule

   



