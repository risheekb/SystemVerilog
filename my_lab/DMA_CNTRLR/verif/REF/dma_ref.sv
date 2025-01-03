class dma_ref;
  dma_ctrl_reg_block reg_block_h = new();
  apb_tx tx_h;
  bit [31:0] rd_data_reg;
  task run();
    $display("dma_ref::run");
    fork
      forever begin
        @(posedge dma_common::dut_reset_applied);
        reg_block_h.reset_reg();
      end
      forever begin 
        tx_h = new();
        dma_common::apbmon2ref.get(tx_h);
        if(tx_h.wr_rd)
          reg_block_h.write_reg(tx_h.addr,tx_h.data);
        else begin
          rd_data_reg = reg_block_h.read_reg(tx_h.addr);
          if(rd_data_reg != tx_h.data) begin
            $display("ERROR REGISTER MISMATCH");
            $display("Register Address:= %h DUT read data:= %h Register Model Read Data:= %h",tx_h.addr,tx_h.data,rd_data_reg);
            dma_common::error_count +=1;
          end
        end
      end
    join
  endtask
endclass
