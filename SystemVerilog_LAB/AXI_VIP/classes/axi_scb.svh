class axi_scb;

  axi_tx tx;
  axi_tx writeq[bit[3:0]];
  axi_tx readq[bit[3:0]];
  virtual task run();
    $display("SCB RUNNING");
    repeat(axi_common::tx_count *2)begin
      axi_common::mon2scb.get(tx);
      $display("%m ####################################");
      if(tx.wr_rd == WRITE)begin
        writeq[tx.id] = new tx;
        
      end

      if(tx.wr_rd == READ) begin
        readq[tx.id] = new tx;
        if(writeq[tx.id] != null) begin
          foreach(writeq[tx.id].dataQ[i]) begin
            if(writeq[tx.id].dataQ[i] == tx.dataQ[i])
              $display("data match write_addr = %h write_data = %h read_addr = %h read_data = %h",writeq[tx.id].addr,writeq[tx.id].dataQ[i],tx.addr,tx.dataQ[i]);
            else
              $error("data mismatch");
          end
        end

      end
      tx.print();
    end
  endtask  
endclass
