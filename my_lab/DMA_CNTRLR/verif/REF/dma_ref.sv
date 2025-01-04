class dma_ref;
  dma_ctrl_reg_block reg_block_h = new();
  apb_tx apb_tx_h;
  axi_tx axi_tx_h;
  bit [31:0] rd_data_reg;
  task run();
    $display("dma_ref::run");
    fork
      forever begin //Check for DUT reset if applied,apply the same to reg model.
        @(posedge dma_common::dut_reset_applied);
        reg_block_h.reset_reg();
      end
      //Thread to collect APB transactions
      forever begin 
        apb_tx_h = new();
        dma_common::apbmon2ref.get(apb_tx_h);
        if(apb_tx_h.wr_rd)
          reg_block_h.write_reg(apb_tx_h.addr,apb_tx_h.data);
        else begin
          rd_data_reg = reg_block_h.read_reg(apb_tx_h.addr);
          if(rd_data_reg != apb_tx_h.data) begin
            $display("ERROR REGISTER MISMATCH");
            $display("Register Address:= %h DUT read data:= %h Register Model Read Data:= %h",apb_tx_h.addr,apb_tx_h.data,rd_data_reg);
            dma_common::error_count +=1;
          end
        end
      end
      //Thread to collect AXI transactions.
      forever begin
        dma_common::aximon2ref.get(axi_tx_h);
        axi_tx_h.print();
      end

    join
  endtask
endclass
