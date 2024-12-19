class apb_bfm;
  apb_tx tx_h;
  virtual apb_inf.master_mp vif;
  task run();
    vif = dma_common::apb_vif;
    $display("apb_bfm::run");
    forever begin
      tx_h = new();
      dma_common::gen2bfm.get(tx_h);
      drive_tx(tx_h);
    end
  endtask

    task drive_tx(apb_tx tx_h);
      @(vif.master_cb);
      vif.master_cb.paddr <= tx_h.addr;
      vif.master_cb.pwrite <= tx_h.wr_rd;
      vif.master_cb.pclken <= 1;
      vif.master_cb.psel <= 1;
      vif.master_cb.penable <= 1;
      if(tx_h.wr_rd) vif.master_cb.pwdata <= tx_h.data;
      wait(vif.master_cb.pready)
      vif.master_cb.paddr <= 0;
      vif.master_cb.pwrite <= 0;
      vif.master_cb.pclken <= 0;
      vif.master_cb.psel <= 0;
      vif.master_cb.penable <= 0;
      if(tx_h.wr_rd) vif.master_cb.pwdata <= 0;
    endtask

endclass
