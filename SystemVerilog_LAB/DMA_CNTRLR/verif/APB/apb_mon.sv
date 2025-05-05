class apb_mon;
  virtual apb_inf.monitor_mp vif;
  apb_tx tx_h;
  task run();
    $display("apb_mon::run");
    vif = dma_common::apb_vif;
    forever begin 
      @(vif.monitor_cb);
      if(!vif.monitor_cb.penable && vif.monitor_cb.pready) begin //Checking if the APB transaction is avalid
        tx_h = new();
        tx_h.addr = vif.monitor_cb.paddr;
        tx_h.wr_rd = vif.monitor_cb.pwrite;
        fork 
          if(vif.monitor_cb.pwrite) begin
            tx_h.data = vif.monitor_cb.pwdata;
            dma_common::mon2cov.put(tx_h);
            dma_common::apbmon2ref.put(tx_h);
          end
          else begin
            @(vif.monitor_cb);
            tx_h.data = vif.monitor_cb.prdata;
            dma_common::mon2cov.put(tx_h);
            dma_common::apbmon2ref.put(tx_h);
          end
        join_none
      end
        
    end
  endtask
endclass

