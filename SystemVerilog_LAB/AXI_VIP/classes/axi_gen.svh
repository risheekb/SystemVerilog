class axi_gen;

    axi_tx tx;
  axi_tx tx_q[$];
  virtual task run();
    $display("axi_gen::run");
    $value$plusargs("testname=%s",axi_common::testname);
    case(axi_common::testname)
      "test_5_wr": begin
        repeat(5) begin
          tx = new();
          if(!tx.randomize()with {wr_rd == WRITE;}) $display("%m Randomization failed!!!");
          axi_common::gen2bfm.put(tx);
        end
      end

      "test_5_wr_5_rd":begin
          axi_common::total_gen_tx_count = 2*axi_common::tx_count;
        for(int i = 0;i<axi_common::tx_count;i++)begin
          tx = new();
          if(!tx.randomize()with {wr_rd == WRITE;}) $display("%m Randomization failed!!!");
          axi_common::gen2bfm.put(tx);
          tx_q[i] = new tx;
        end
        for(int i =0;i<axi_common::tx_count;i++) begin
          tx = new();
          if(!tx.randomize()with {wr_rd == READ;
            addr == tx_q[i].addr;
            len == tx_q[i].len;
            burst_size == tx_q[i].burst_size;
            id == tx_q[i].id;
            burst_type == tx_q[i].burst_type;}) $display("%m Randomization failed!!!");

          axi_common::gen2bfm.put(tx);
        end
      end
      "test_wrap_wr_rd":begin
        axi_common::total_gen_tx_count = 2 * axi_common::tx_count;
        for(int i = 0;i<axi_common::tx_count;i++) begin
          tx = new();
          if(!tx.randomize() with {wr_rd == WRITE; burst_type == WRAP;}) $fatal(0,"%m Randomization Failed");
          tx.print("GEN");
          axi_common::gen2bfm.put(tx);
          tx_q[i] = new tx;
        end
        for(int i = 0;i<axi_common::tx_count;i++) begin
          tx = new();
          if(!tx.randomize() with {wr_rd==READ;
            addr == tx_q[i].addr;
            len == tx_q[i].len;
            burst_size == tx_q[i].burst_size;
            id == tx_q[i].id;
            burst_type == tx_q[i].burst_type;})
           $fatal(0,"%m Randomization Failed");
            axi_common::gen2bfm.put(tx);
        end
      end
    endcase

  endtask
endclass
