class dma_ref;
  dma_ctrl_reg_block reg_block_h = new();
  apb_tx apb_tx_h;
  axi_tx axi_tx_h;
  bit [31:0] rd_data_reg;
  bit [3:0] wr_active_channel;
  bit [3:0] rd_active_channel;
  byte  wr_aq[7:0][$]; 
  byte  rd_aq[7:0][$]; 
  byte rd_byte;
  byte wr_byte;
  int size;
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
        if(axi_tx_h.wr_rd == READ) begin
          if(axi_tx_h.rd_addr inside{[32'h1000_0000:1001_0000]}) rd_active_channel = 0;
          if(axi_tx_h.rd_addr inside{[32'h1001_0000:1002_0000]}) rd_active_channel = 1;
          if(axi_tx_h.rd_addr inside{[32'h1002_0000:1003_0000]}) rd_active_channel = 2;
          if(axi_tx_h.rd_addr inside{[32'h1003_0000:1004_0000]}) rd_active_channel = 3;
          if(axi_tx_h.rd_addr inside{[32'h1004_0000:1005_0000]}) rd_active_channel = 4;
          if(axi_tx_h.rd_addr inside{[32'h1005_0000:1006_0000]}) rd_active_channel = 5;
          if(axi_tx_h.rd_addr inside{[32'h1006_0000:1007_0000]}) rd_active_channel = 6;
          if(axi_tx_h.rd_addr inside{[32'h1007_0000:1008_0000]}) rd_active_channel = 7;
          for(int j = 0;j<=axi_tx_h.rd_len;j++) begin
            for(int k = 0;k<=2**axi_tx_h.rd_size;k++)begin
              rd_aq[rd_active_channel].push_back(axi_tx_h.rd_data_q[j][7:0]);
              axi_tx_h.rd_data_q[j] >>= 8;
            end
          end
        end
        if(axi_tx_h.wr_rd == WRITE) begin
          if(axi_tx_h.wr_addr inside{[32'h2000_0000:2001_0000]}) wr_active_channel = 0;
          if(axi_tx_h.wr_addr inside{[32'h2001_0000:2002_0000]}) wr_active_channel = 1;
          if(axi_tx_h.wr_addr inside{[32'h2002_0000:2003_0000]}) wr_active_channel = 2;
          if(axi_tx_h.wr_addr inside{[32'h2003_0000:2004_0000]}) wr_active_channel = 3;
          if(axi_tx_h.wr_addr inside{[32'h2004_0000:2005_0000]}) wr_active_channel = 4;
          if(axi_tx_h.wr_addr inside{[32'h2005_0000:2006_0000]}) wr_active_channel = 5;
          if(axi_tx_h.wr_addr inside{[32'h2006_0000:2007_0000]}) wr_active_channel = 6;
          if(axi_tx_h.wr_addr inside{[32'h2007_0000:2008_0000]}) wr_active_channel = 7;

          for(int j = 0;j<=axi_tx_h.wr_len;j++) begin
            for(int k = 0;k<=2**axi_tx_h.wr_size;k++)begin
              wr_aq[wr_active_channel].push_back(axi_tx_h.wr_data_q[j][7:0]);
              axi_tx_h.wr_data_q[j] >>= 8;
            end
          end
        end
      end

      //Thread to compare the read and write bytes.
      forever begin
        wait(wr_aq[wr_active_channel].size() >0);
        wait(rd_aq[rd_active_channel].size() >0);
        size = wr_aq[wr_active_channel].size();
        for(int i = 0;i<size;i++) begin
          wr_byte = wr_aq[wr_active_channel].pop_front;
          rd_byte = rd_aq[rd_active_channel].pop_front;
          if(wr_byte != rd_byte) begin
            dma_common::data_mismatch++;
            $display("ERROR DATA MISMATCH wr_byte = %h rd_byte = %h",wr_byte,rd_byte);
          end
        else begin
          dma_common::data_match++;
          $display("DATA MATCH wr_byte = %h rd_byte = %h",wr_byte,rd_byte);
        end
        end
        wr_aq[wr_active_channel].delete();
        rd_aq[rd_active_channel].delete();
      end

    join
  endtask
endclass
