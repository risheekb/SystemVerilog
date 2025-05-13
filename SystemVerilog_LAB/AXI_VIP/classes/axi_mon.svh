class axi_mon;

  virtual axi_inf vif;
  axi_tx tx;
  function new();
  endfunction
  virtual task run();
    vif = axi_common::vif;
    $display("axi_mon::run");
    forever begin
      //@(posedge vif.aclk);
      
      if(vif.awvalid == 1 )  begin
       wait(vif.awready == 1);
        tx = new();
        //$display("%m WA PHASE entered here");
        tx.addr = vif.awaddr;
        tx.len = vif.awlen;
        tx.id = vif.awid;
        tx.wr_rd = WRITE;
        tx.lock = lock_t'(vif.awlock);
        tx.burst_size = burst_size_t'(vif.awsize);
        tx.prot = vif.awprot;
        tx.cache = vif.awcache;
        tx.burst_type = burst_t'(vif.awburst);
      end


      if(vif.wvalid ) begin
          wait(vif.wready);
          tx.dataQ.push_back(vif.wdata);
        //$display("%m WDATA phase entered here");
      end
      if(vif.bvalid) begin
        wait(vif.bready);
        //$display("%m WRESP PHASE entered here");
        tx.resp = resp_t'(vif.bresp);
        axi_common::mon2scb.put(tx);
      end
      
     @(negedge vif.aclk) 
      if(vif.arvalid == 1 )  begin
       wait(vif.arready == 1);
        tx = new();
        //$display("%m WA PHASE entered here");
        tx.addr = vif.araddr;
        tx.len = vif.arlen;
        tx.id = vif.arid;
        tx.wr_rd = READ;
        tx.lock = lock_t'(vif.arlock);
        tx.burst_size = burst_size_t'(vif.arsize);
        tx.prot = vif.arprot;
        tx.cache = vif.arcache;
        tx.burst_type = burst_t'(vif.arburst);
      end


      if(vif.rvalid) begin
          wait(vif.rready);
          tx.dataQ.push_back(vif.rdata);
        if(vif.rlast) begin
          tx.resp = resp_t'(vif.rresp);
          axi_common::mon2scb.put(tx);
        end
        //$display("%m WDATA phase entered here");
      end

    end
  endtask
endclass
