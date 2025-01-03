class axi_responder;
  bit [`ID_BITS-1:0]               awid_t;
  bit [32-1:0]                     awaddr_t;
  bit [`LEN_BITS-1:0]              awlen_t;
  bit [`SIZE_BITS-1:0]             awsize_t;

  bit [`ID_BITS-1:0]               arid_t;
  bit [32-1:0]                     araddr_t;
  bit [`LEN_BITS-1:0]              arlen_t;
  bit [`SIZE_BITS-1:0]             arsize_t;
  virtual axi_inf.slave_mp vif;
  byte mem[int]; //memory for the slave responder
  task init_mem;
    for(int i = 0;i<4096;i++) begin
      mem[32'h1000_0000+i] = $random;
      mem[32'h1001_0000+i] = $random;
      mem[32'h1002_0000+i] = $random;
      mem[32'h1003_0000+i] = $random;
      mem[32'h1004_0000+i] = $random;
      mem[32'h1005_0000+i] = $random;
      mem[32'h1006_0000+i] = $random;
      mem[32'h1007_0000+i] = $random;
    end
  endtask
  task run();
    $display("axi_responder::run");
    vif = dma_common::axi_vif;
    wait (vif.slave_cb.reset == 0);
    init_mem;
    forever begin
      //write request
      // write address request
      @(vif.slave_cb);
      if(vif.slave_cb.awvalid == 1) begin
        vif.slave_cb.awready <= 1;
        awid_t = vif.slave_cb.awid;
        awaddr_t = vif.slave_cb.awaddr;
        awlen_t = vif.slave_cb.awlen;
        awsize_t = vif.slave_cb.awsize;
        $display("awid_t %d AWADDR =%h awlen_t =%H awsize_t = %h",awid_t,awaddr_t,awlen_t,awsize_t);
      end
      else begin
        vif.slave_cb.awready <= 0;
      end
      // write data request 
      if(vif.slave_cb.wvalid == 1) begin
        vif.slave_cb.wready <= 1;
        mem[awaddr_t] = vif.slave_cb.wdata[7:0];
        mem[awaddr_t+1] = vif.slave_cb.wdata[15:8];
        mem[awaddr_t+2] = vif.slave_cb.wdata[23:16];
        mem[awaddr_t+3] = vif.slave_cb.wdata[31:24];
        mem[awaddr_t+4] = vif.slave_cb.wdata[39:32];
        mem[awaddr_t+5] = vif.slave_cb.wdata[47:40];
        mem[awaddr_t+6] = vif.slave_cb.wdata[55:48];
        mem[awaddr_t+7] = vif.slave_cb.wdata[63:56];
        $display("location1 : %h ",vif.slave_cb.wdata);
        awaddr_t += 2**awsize_t;
        if(vif.slave_cb.wlast == 1) begin
          write_response_phase();
        end
      end
      else begin
        vif.slave_cb.wready <= 0;
      end
      //read request
      if(vif.slave_cb.arvalid == 1) begin
        vif.slave_cb.arready <= 1;
        arid_t = vif.slave_cb.arid;
        araddr_t = vif.slave_cb.araddr;
        arlen_t = vif.slave_cb.arlen;
        arsize_t = vif.slave_cb.arsize;
        read_data_phase();
      end
      else begin
        vif.slave_cb.arready <= 0;
      end

      // read address request
      // read data request 
    end
  endtask
  task read_data_phase();
    for(int i =0;i<=arlen_t;i++) begin
      $display("########## %h ",araddr_t);
      vif.slave_cb.rdata <= {mem[araddr_t+7],mem[araddr_t+6],mem[araddr_t+5],mem[araddr_t+4],mem[araddr_t+3],mem[araddr_t+2],mem[araddr_t+1],mem[araddr_t+0]};
      vif.slave_cb.rvalid <= 1;
      vif.slave_cb.rid <= arid_t;
      vif.slave_cb.rresp <= 2'b00;//OKAY RESPONSE
      if(i==arlen_t) vif.slave_cb.rlast <= 1;
      @(vif.slave_cb);
      wait(vif.slave_cb.rready == 1);
      araddr_t += 2**arsize_t;
    end
    vif.slave_cb.rdata <= 0;
    vif.slave_cb.rvalid <= 0;
    vif.slave_cb.rid <= 0;
    vif.slave_cb.rlast <= 0;
  endtask
  task write_response_phase();
    vif.slave_cb.bresp <= 2'b00;
    vif.slave_cb.bvalid <= 1;
    vif.slave_cb.bid <= awid_t;
    @(vif.slave_cb);
    wait(vif.slave_cb.bready == 1);
    vif.slave_cb.bresp <= 2'b00;
    vif.slave_cb.bvalid <= 0;
    vif.slave_cb.bid <= 0;
  endtask
endclass
