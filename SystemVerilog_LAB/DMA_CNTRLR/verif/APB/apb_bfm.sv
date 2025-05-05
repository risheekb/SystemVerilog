class apb_bfm;
  apb_tx tx_h;
  virtual apb_inf.master_mp vif;
  virtual periph_inf pvif;
  task run();
    vif = dma_common::apb_vif;
    pvif = dma_common::periph_vif;
    wait (vif.master_cb.reset == 0);
    $display("apb_bfm::run");
    forever begin
      tx_h = new();
      dma_common::gen2bfm.get(tx_h);
      //tx_h.print();
      if(tx_h.apb_or_periph_f == APB) begin
        drive_tx(tx_h);
      end
      else begin
        @(posedge pvif.clk);
        pvif.periph_tx_req[tx_h.tx_periph] = 1;
        pvif.periph_rx_req[tx_h.rx_periph] = 1;
        wait(pvif.periph_tx_clr[tx_h.tx_periph] == 1);
        wait(pvif.periph_rx_clr[tx_h.rx_periph] == 1);
        pvif.periph_tx_req[tx_h.tx_periph] = 0;
        pvif.periph_rx_req[tx_h.rx_periph] = 0;
      end
      dma_common::txn_driv++;
    end
  endtask

    task drive_tx(apb_tx tx_h);
      vif.master_cb.paddr <= tx_h.addr;
      vif.master_cb.pwrite <= tx_h.wr_rd;
      vif.master_cb.pclken <= 1;
      vif.master_cb.psel <= 1;
      vif.master_cb.penable <= 0;
      if(tx_h.wr_rd) vif.master_cb.pwdata <= tx_h.data;
      @(vif.master_cb);
      wait(vif.master_cb.pready)
      vif.master_cb.paddr <= 0;
      vif.master_cb.pwrite <= 0;
      vif.master_cb.pclken <= 0;
      vif.master_cb.psel <= 0;
      vif.master_cb.penable <= 1;
      if(tx_h.wr_rd) vif.master_cb.pwdata <= 0;
    endtask

endclass
