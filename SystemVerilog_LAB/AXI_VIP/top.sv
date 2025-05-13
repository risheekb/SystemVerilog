module top;
  import axi_pkg::*;
  logic clk,rst;

  axi_inf inf(clk,rst);

  axi_env env;

  axi_assertion axi_assertion_i();
  //axi_memory dut(inf.slave_mp);
  axi_memory dut(
	 .aclk(inf.aclk),
	 .arst(inf.arst),
	 .awid(inf.awid),
	 .awaddr(inf.awaddr),
	 .awlen(inf.awlen),
	 .awsize(inf.awsize),
	 .awburst(inf.awburst),
	 .awlock(inf.awlock),
	 .awcache(inf.awcache),
	 .awprot(inf.awprot),
	 .awvalid(inf.awvalid),
	 .awready(inf.awready),
	 .wid(inf.wid),
	 .wdata(inf.wdata),
	 .wstrb(inf.wstrb),
	 .wlast(inf.wlast),
	 .wvalid(inf.wvalid),
	 .wready(inf.wready),
	 .bid(inf.bid),
	 .bresp(inf.bresp),
	 .bvalid(inf.bvalid),
	 .bready(inf.bready),
	 .arid(inf.arid),
	 .araddr(inf.araddr),
	 .arlen(inf.arlen),
	 .arsize(inf.arsize),
	 .arburst(inf.arburst),
	 .arlock(inf.arlock),
	 .arcache(inf.arcache),
	 .arprot(inf.arprot),
	 .arvalid(inf.arvalid),
	 .arready(inf.arready),
	 .rid(inf.rid),
	 .rdata(inf.rdata),
	 .rlast(inf.rlast),
	 .rvalid(inf.rvalid),
	 .rready(inf.rready),
	 .rresp(inf.rresp)
  ); //slave model.


  initial begin
    //env = new();
    clk =0;
    forever #5 clk = ~clk;
  end

  initial begin
    rst = 1;
    reset_design_inputs();
    @(posedge clk);
    rst = 0;
  end

  initial begin
    axi_common::vif = inf;
    env = new();
    //fork
    env.run();
    //#2000;
    //join_any
    //disable fork;

  end

  initial begin 
    #100;
    wait(axi_common::total_gen_tx_count == axi_common::total_driven_tx_count);
    #100;
    $display("total_gen_tx_count =%d \n total_driven_tx_count = %d",axi_common::total_gen_tx_count,axi_common::total_driven_tx_count);
    $finish;
 
  end
  task reset_design_inputs();
 	inf.awid=0;
 	inf.awaddr =0;
 	inf.awlen =0;
 	inf.awsize =0;
 	inf.awburst =0;
 	inf.awlock =0;
 	inf.awcache =0;
 	inf.awprot =0;
 	inf.awvalid =0;
 	inf.wid =0;
 	inf.wdata =0;
 	inf.wstrb =0;
 	inf.wlast =0;
 	inf.wvalid =0;
 	inf.bready =0;
 	inf.arid =0;
 	inf.araddr =0;
 	inf.arlen =0;
 	inf.arsize =0;
 	inf.arlock =0;
 	inf.arcache =0;
 	inf.arprot =0;
 	inf.arvalid =0;
 	inf.rready =0;
  
  endtask

endmodule
