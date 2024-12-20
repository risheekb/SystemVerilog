class apb_gen;
  
  apb_tx tx_h;
  task run();
    $display("apb_gen::run");
    case(dma_common::test_name)
      "test_reg_reset": begin
        dma_common::txn_gen = 37;
        for(int j = 0;j<=7;j++) begin
        //from CH0_CMD_REG0 till CH0_COUNT_REG  
          for(int i = 0;i<=20;i++) begin
            if(i == 19|| i == 9 || i == 10 || i == 17) continue;
            tx_h = new();
            tx_h.randomize() with {addr == 13'h100*j+ 4*i; wr_rd ==0;};
            tx_h.print();
            dma_common::gen2bfm.put(tx_h);
            dma_common::txn_gen++;
          end
          //for A0 to AC
          for(int i = 40; i<=43;i++) begin
            if(i == 41) continue;
            tx_h = new();
            tx_h.randomize() with {addr ==13'h100*j+i*4;wr_rd ==0;};
            tx_h.print();
            dma_common::gen2bfm.put(tx_h);
            dma_common::txn_gen++;
          end
        end
        //shared registers
        for(int i = 0; i<=7;i++) begin
          if(i > 0) continue;
          tx_h = new();
          tx_h.randomize() with {addr == 13'h1000 +i*4;wr_rd ==0;};
          tx_h.print();
          dma_common::gen2bfm.put(tx_h);
          dma_common::txn_gen++;
        end
        for(int i = 12; i<=21;i++) begin
          if(i == 13 || i == 15 || i == 17 || i == 18 || i == 19) continue;
          tx_h = new();
          tx_h.randomize() with {addr == 13'h1000 +i*4;wr_rd ==0;};
          tx_h.print();
          dma_common::gen2bfm.put(tx_h);
          dma_common::txn_gen++;
        end
      end
      "test_wr_rd": begin
        dma_common::txn_gen = 37;
        for(int j = 0;j<=7;j++) begin
        //from CH0_CMD_REG0 till CH0_COUNT_REG  
          for(int i = 0;i<=20;i++) begin
            //if(i == 19|| i == 9 || i == 10 || i == 17) continue;
            if(i == 9 || i == 10 || i == 11 || i == 12 || i == 13 || i == 14 || i == 15 || i == 18 || i == 19 || i == 20) continue;
            if(i == 19) continue;
            tx_h = new();
            tx_h.randomize() with {addr == 13'h100*j+ 4*i; wr_rd ==1;};
            tx_h.print();
            dma_common::gen2bfm.put(tx_h);
            dma_common::txn_gen++;
          end
          //for A0 to AC
          for(int i = 40; i<=43;i++) begin
            if(i == 43) continue;
            tx_h = new();
            tx_h.randomize() with {addr ==13'h100*j+i*4;wr_rd ==1;};
            tx_h.print();
            dma_common::gen2bfm.put(tx_h);
            dma_common::txn_gen++;
          end
        end
        for(int i = 12; i<=21;i++) begin
          if(i == 13 || i == 15 || i == 17 ||  i == 19) continue;
          tx_h = new();
          tx_h.randomize() with {addr == 13'h1000 +i*4;wr_rd ==1;};
          tx_h.print();
          dma_common::gen2bfm.put(tx_h);
          dma_common::txn_gen++;
        end
        //READING ALL THE REGISTERS
        for(int j = 0;j<=7;j++) begin
        //from CH0_CMD_REG0 till CH0_COUNT_REG  
          for(int i = 0;i<=20;i++) begin
            if(i == 19|| i == 9 || i == 10 || i == 17) continue;
            tx_h = new();
            tx_h.randomize() with {addr == 13'h100*j+ 4*i; wr_rd ==0;};
            tx_h.print();
            dma_common::gen2bfm.put(tx_h);
            dma_common::txn_gen++;
          end
          //for A0 to AC
          for(int i = 40; i<=43;i++) begin
            if(i == 41) continue;
            tx_h = new();
            tx_h.randomize() with {addr ==13'h100*j+i*4;wr_rd ==0;};
            tx_h.print();
            dma_common::gen2bfm.put(tx_h);
            dma_common::txn_gen++;
          end
        end
        //shared registers
        for(int i = 0; i<=7;i++) begin
          if(i > 0) continue;
          tx_h = new();
          tx_h.randomize() with {addr == 13'h1000 +i*4;wr_rd ==0;};
          tx_h.print();
          dma_common::gen2bfm.put(tx_h);
          dma_common::txn_gen++;
        end
        for(int i = 12; i<=21;i++) begin
          if(i == 13 || i == 15 || i == 17 || i == 18 || i == 19) continue;
          tx_h = new();
          tx_h.randomize() with {addr == 13'h1000 +i*4;wr_rd ==0;};
          tx_h.print();
          dma_common::gen2bfm.put(tx_h);
          dma_common::txn_gen++;
        end
      end
    endcase
  endtask
endclass
