class apb_gen;
  
  apb_tx tx_h;
  task run();
    $display("apb_gen::run");
    case(dma_common::test_name)
      "test_reg_reset": begin
        for(int j = 0;j<=7;j++) begin
        //from CH0_CMD_REG0 till CH0_COUNT_REG  
          for(int i = 0;i<=20;i++) begin
            if(i == 19) continue;
            tx_h = new();
            tx_h.randomize() with {addr == 13'h100*j+i*4; wr_rd ==0;};
            tx_h.print();
            dma_common::gen2bfm.put(tx_h);
          end
          //for A0 to AC
          for(int i = 40; i<=43;i++) begin
            tx_h = new();
            tx_h.randomize() with {addr ==13'h100*j+i*4;wr_rd ==0;};
            tx_h.print();
            dma_common::gen2bfm.put(tx_h);
          end
        end
        //shared registers
        for(int i = 0; i<=7;i++) begin
          tx_h = new();
          tx_h.randomize() with {addr == 13'h1000 +i*4;wr_rd ==0;};
          tx_h.print();
          dma_common::gen2bfm.put(tx_h);
        end
      end
    endcase
  endtask
endclass
