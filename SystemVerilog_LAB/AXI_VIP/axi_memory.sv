
//module axi_memory import axi_pkg::*; (axi_slave_mp ;
module axi_memory import axi_pkg::*; (
input aclk, arst,
input [3:0] awid,
input [31:0] awaddr,
input [3:0] awlen,
input [2:0] awsize,
input [1:0] awburst,
input [1:0] awlock,
input [3:0] awcache,
input [2:0] awprot,
input awvalid,
output logic awready,
input [3:0] wid,
input [63:0] wdata,
input [3:0] wstrb,
input wlast,
input wuser,
input wvalid,
output logic wready,
output logic [3:0] bid,
output logic [1:0] bresp,
output logic buser,
output logic bvalid,
input bready,
//read signal
input [3:0] arid,
input [31:0] araddr,
input [3:0] arlen,
input [2:0] arsize,
input [1:0] arburst,
input [1:0] arlock,
input [3:0] arcache,
input [2:0] arprot,
input arvalid,
output logic arready,
output logic [3:0] rid,
output logic [63:0] rdata,
output logic rlast,
output logic ruser,
output logic rvalid,
input rready,
output logic [1:0] rresp
);
  
  int total_tx_size;
  logic [31:0] mem [int];
  logic [3:0] awid_t;
  logic [31:0] awaddr_t;
  logic [31:0] lower_wrap_waddr;
  logic [31:0] upper_wrap_waddr;
  logic [3:0] awlen_t;
  logic [2:0] awsize_t;
  logic [1:0] awburst_t;
  
  logic [3:0] arid_t;
  logic [31:0] araddr_t;
  logic [31:0] lower_wrap_raddr;
  logic [31:0] upper_wrap_raddr;
  logic [3:0] arlen_t;
  logic [2:0] arsize_t;
  logic [1:0] arburst_t;
  //slave needs to complete handshaking 
  always @(negedge aclk) begin
    if(arst == 1) begin
      arready = 0;
      awready = 0;
      wready = 0;
      rid = 0;
      rdata = 0;
      rlast = 0;
      rvalid = 0;
      bid = 0;
      bvalid = 0;
      bresp = 0;
      rresp = 0;


    end
    else begin

      //WA CHANNEL HANDSHAKE
      if(awvalid == 1'b1) begin
        awready = 1'b1;
        awid_t = awid;
        awaddr_t = awaddr;
        awlen_t = awlen;
        awsize_t =awsize;
        awburst_t =awburst;
        if(burst_t'(awburst_t) == WRAP) calc_w_upper_wrap_boundary();
        $display("lower_w_wrap_boundary = %h upper_w_wrap_boundary=%h",lower_wrap_waddr,upper_wrap_waddr);
      end
      else begin
        awready = 1'b0;
      end
      //WDATA CHANNEL HANDSHAKE
      if(wvalid == 1) begin
        wready = 1;
        store_wr_data();
        if(wlast == 1) begin
          //bvalid = 1'b1;
          write_resp_phase(wid);
        end
      end
      else begin
        wready = 1'b0;
      end
      
      //RA CHANNEL HANDSHAKE
      if(arvalid == 1'b1)begin
        arready = 1'b1;
        arid_t = arid;
        araddr_t = araddr;
        arlen_t = arlen;
        arsize_t =arsize;
        if(burst_t'(arburst) == WRAP) calc_r_upper_wrap_boundary();
        $display("lower_r_wrap_boundary = %h upper_r_wrap_boundary=%h",lower_wrap_raddr,upper_wrap_raddr);
        drive_rd_data();
      end
      else begin
        arready = 1'b0;
      end


    end
  end


task write_resp_phase(input [3:0] id);
	@(negedge aclk);
	bvalid = 1;
	bid = id;
	bresp = 2'b00;
	wait (bready == 1);
	@(negedge aclk);
	bvalid = 0;
endtask


task store_wr_data();
  $display("address = %h write_data = %h",awaddr_t,wdata);
  if(awsize_t == 0)
    mem[awaddr_t] = wdata[7:0];
  if(awsize_t == 1) begin
    mem[awaddr_t] = wdata[7:0];
    mem[awaddr_t+1] = wdata[15:8];
  end
  if(awsize_t == 2) begin
    mem[awaddr_t] = wdata[7:0];
    mem[awaddr_t+1] = wdata[15:8];
    mem[awaddr_t+2] = wdata[23:16];
    mem[awaddr_t+3] = wdata[31:24];
  end
  if(awsize_t == 3) begin
    mem[awaddr_t] = wdata[7:0];
    mem[awaddr_t+1] = wdata[15:8];
    mem[awaddr_t+2] = wdata[23:16];
    mem[awaddr_t+3] = wdata[31:24];
    mem[awaddr_t+4] = wdata[39:32];
    mem[awaddr_t+5] = wdata[47:40];
    mem[awaddr_t+6] = wdata[55:48];
    mem[awaddr_t+7] = wdata[63:56];
  end
  awaddr_t += (2**awsize_t);
  if(awaddr_t >= upper_wrap_waddr) awaddr_t = lower_wrap_waddr;
endtask

task drive_rd_data();
  for(int i = 0;i<=arlen_t;i++) begin

    @(negedge aclk);
    if(arsize_t == 0)

      rdata[7:0]    = mem[araddr_t];
    if(arsize_t == 1) begin
      rdata[7:0]    = mem[araddr_t];
      rdata[15:8]    = mem[araddr_t+1];
    end
    if(arsize_t == 2) begin
      rdata[7:0]    = mem[araddr_t];
      rdata[15:8]    = mem[araddr_t+1];
      rdata[23:16]    = mem[araddr_t+2];
      rdata[31:24]    = mem[araddr_t+3];
    end
    if(arsize_t == 3) begin
      rdata[7:0]    = mem[araddr_t]  ;
      rdata[15:8]    = mem[araddr_t+1] ;
      rdata[23:16]    = mem[araddr_t+2] ;
      rdata[31:24]    = mem[araddr_t+3] ;
      rdata[39:32]    = mem[araddr_t+4] ;
      rdata[47:40]    = mem[araddr_t+5] ;
      rdata[55:48]    = mem[araddr_t+6] ;
      rdata[63:56]    = mem[araddr_t+7] ;
    end
  $display("address = %h read_data= %h",araddr_t,rdata);
    rvalid = 1;
    //rid = arid_t;
    rresp = 2'b00;
    rlast = (i == arlen_t)?1:0;
    wait(rready == 1);
    araddr_t += (2**arsize_t);
    if(araddr_t >= upper_wrap_raddr) araddr_t = lower_wrap_raddr;
  end
  @(negedge aclk);
  rvalid = 0;
  rlast = 0;
  rdata=0;

endtask
task calc_w_upper_wrap_boundary();
  total_tx_size = (2**awsize) * (awlen+1);
  lower_wrap_waddr = awaddr - (awaddr % total_tx_size);
  upper_wrap_waddr = lower_wrap_waddr + total_tx_size - 1;
endtask
task calc_r_upper_wrap_boundary();
  total_tx_size = (2**arsize) * (arlen+1);
  lower_wrap_raddr = araddr - (araddr % total_tx_size);
  upper_wrap_raddr = lower_wrap_raddr + total_tx_size - 1;
endtask

endmodule

