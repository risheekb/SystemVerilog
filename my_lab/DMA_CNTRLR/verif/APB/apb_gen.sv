class apb_gen;
  
  apb_tx tx_h;
  task run();
    $display("apb_gen::run");
    $value$plus$args("test_name=%s",dma_common::test_name);
    case(dma_common::test_name)
      "test_reg_reset": begin
        tx_h = new();
        tx_h.randomize() with {addr == 13'h0; wr_rd ==0;};
        dma_common::gen2bfm.put(tx_h);
      end
    endcase
  endtask
endclass
