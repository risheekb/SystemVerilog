
class axi_mon;
  axi_tx axi_tx_h;
  virtual axi_inf.monitor_mp vif;

  task run();
    $display("axi_mon::run");
    vif = dma_common::axi_vif;
    wait(vif.monitor_cb.reset == 0);
    forever begin
      @(vif.monitor_cb);
      //WRITE ADDRESS COLLECTION
      if(vif.monitor_cb.awvalid && vif.monitor_cb.awready) begin //WRITE address phase is valid
        axi_tx_h = new();
        axi_tx_h.wr_rd = WRITE;
        axi_tx_h.wr_addr = vif.monitor_cb.awaddr;
        axi_tx_h.wr_len = vif.monitor_cb.awlen;
        axi_tx_h.wr_size = vif.monitor_cb.awsize;
        axi_tx_h.wr_id = vif.monitor_cb.wid;
      end
      //WRITE DATA COLLECTION
      if(vif.monitor_cb.wvalid && vif.monitor_cb.wready) begin //WRITE data phase is valid
        axi_tx_h.wr_data_q.push_back(vif.monitor_cb.wdata);
        axi_tx_h.strb_q.push_back(vif.monitor_cb.wstrb);
      end
      //WRITE RESPONSE COLLECTION
      if(vif.monitor_cb.bvalid && vif.monitor_cb.bready) begin // WRITE response phase is valid
        axi_tx_h.wr_resp = vif.monitor_cb.bid;
        //axi_tx_h.print();
        dma_common::aximon2ref.put(axi_tx_h);
      end

      //READ ADDRESS COLLECTION
      //@(vif.monitor_cb);
      if(vif.monitor_cb.arvalid && vif.monitor_cb.arready) begin // READ address phase is valid
        axi_tx_h = new();
        axi_tx_h.wr_rd = READ;
        axi_tx_h.rd_addr = vif.monitor_cb.araddr;
        axi_tx_h.rd_len = vif.monitor_cb.arlen;
        axi_tx_h.rd_size = vif.monitor_cb.arsize;
        axi_tx_h.rd_id = vif.monitor_cb.arid;
      end
      if(vif.monitor_cb.rvalid && vif.monitor_cb.rready) begin
        axi_tx_h.rd_data_q.push_back(vif.monitor_cb.rdata);
        axi_tx_h.rd_resp = vif.monitor_cb.rresp;
        if(vif.monitor_cb.rlast) dma_common::aximon2ref.put(axi_tx_h);
        //axi_tx_h.print();
      end

      end
  endtask
endclass

