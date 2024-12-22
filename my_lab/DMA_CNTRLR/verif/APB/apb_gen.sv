class apb_gen;
  apb_tx tx_h;
  bit [31:0] data_t;
  task run();
    $display("apb_gen::run");
    case(dma_common::test_name)
      "test_ch0_sanity":begin
        //configure and start the channel
        //section general configuration
        general_config();
        configure_start_ch;
      end
      "test_reg_reset": begin
        for(int j = 0;j<=7;j++) begin
        //from CH0_CMD_REG0 till CH0_COUNT_REG  
          for(int i = 0;i<=20;i++) begin
            if(i == 19|| i == 9 || i == 10 || i == 17) continue;
            tx_h = new();
            tx_h.randomize() with {addr == 13'h100*j+ 4*i; wr_rd ==0;};
            tx_h.print();
            dma_common::gen2bfm.put(tx_h);
          end
          //for A0 to AC
          for(int i = 40; i<=43;i++) begin
            if(i == 41) continue;
            tx_h = new();
            tx_h.randomize() with {addr ==13'h100*j+i*4;wr_rd ==0;};
            tx_h.print();
            dma_common::gen2bfm.put(tx_h);
          end
        end
        //shared registers
        for(int i = 0; i<=7;i++) begin
          if(i > 0) continue;
          tx_h = new();
          tx_h.randomize() with {addr == 13'h1000 +i*4;wr_rd ==0;};
          tx_h.print();
          dma_common::gen2bfm.put(tx_h);
        end
        for(int i = 12; i<=21;i++) begin
          if(i == 13 || i == 15 || i == 17 || i == 18 || i == 19) continue;
          tx_h = new();
          tx_h.randomize() with {addr == 13'h1000 +i*4;wr_rd ==0;};
          tx_h.print();
          dma_common::gen2bfm.put(tx_h);
        end
        dma_common::txn_gen = 166;
      end

      "test_wr_rd": begin
        dma_common::txn_gen = 284;
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
          end
          //for A0 to AC
          for(int i = 40; i<=43;i++) begin
            if(i == 43) continue;
            tx_h = new();
            tx_h.randomize() with {addr ==13'h100*j+i*4;wr_rd ==1;};
            tx_h.print();
            dma_common::gen2bfm.put(tx_h);
          end
        end
        for(int i = 12; i<=21;i++) begin
          if(i == 13 || i == 15 || i == 17 ||  i == 19) continue;
          tx_h = new();
          tx_h.randomize() with {addr == 13'h1000 +i*4;wr_rd ==1;};
          tx_h.print();
          dma_common::gen2bfm.put(tx_h);
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
          end
          //for A0 to AC
          for(int i = 40; i<=43;i++) begin
            if(i == 41) continue;
            tx_h = new();
            tx_h.randomize() with {addr ==13'h100*j+i*4;wr_rd ==0;};
            tx_h.print();
            dma_common::gen2bfm.put(tx_h);
          end
        end
        //shared registers
        for(int i = 0; i<=7;i++) begin
          if(i > 0) continue;
          tx_h = new();
          tx_h.randomize() with {addr == 13'h1000 +i*4;wr_rd ==0;};
          tx_h.print();
          dma_common::gen2bfm.put(tx_h);
        end
        for(int i = 12; i<=21;i++) begin
          if(i == 13 || i == 15 || i == 17 || i == 18 || i == 19) continue;
          tx_h = new();
          tx_h.print();
          dma_common::gen2bfm.put(tx_h);
        end
      end
    endcase
  endtask
  task general_config;
    tx_h = new();
    tx_h.randomize() with {addr == `CORE0_JOINT_MODE; wr_rd ==1; data == 32'h0;};
    tx_h.print();
    dma_common::gen2bfm.put(tx_h);
  endtask
  task configure_start_ch;
    //configure static registers
    configure_static_registers;
    //configure the interrupt controller
    configure_interupt_controller;
    //configure command
    configure_command;
    //enable the channel
    enable_channel;
    //start the channel
    start_channel;
  endtask
  task configure_static_registers;
    //STATIC_REG0
      //rd_burst_max_size = 128
      //rd_allow_full_burst = 0 (independent mode)
      //rd_allow_full_fifo = 1
      //rd_token = 1 (default)
      //rd_outs_max = 4
      //rd__outstanding = 0
      //rd__incr = 1
    //Configure STATIC_REG0
    tx_h = new();
    data_t = {1'b1,1'b0,2'b0,4'h4,2'b0,6'h1,2'b0,1'b1,1'b0,2'b0,10'd128}; 
    tx_h.randomize() with {addr == `CH0_STATIC_REG0;wr_rd ==1;data==data_t;};
    tx_h.print();
    dma_common::gen2bfm.put(tx_h);
    //Configure STATIC_REG1
    tx_h = new();
    data_t = {1'b1,1'b0,2'b0,4'h4,2'b0,6'h1,2'b0,1'b1,1'b0,2'b0,10'd128}; 
    tx_h.randomize() with {addr == `CH0_STATIC_REG1;wr_rd ==1;data==data_t;};
    dma_common::gen2bfm.put(tx_h);
    tx_h = new();
    tx_h.randomize() with {addr == `CH0_STATIC_REG2;wr_rd ==1;data==32'h0;};
    dma_common::gen2bfm.put(tx_h);
  endtask

  task configure_command();
    tx_h = new();
    tx_h.randomize with() {addr == `CH0_CMD_REG0;wr_rd==1;data==32'h1000_0000;};
    tx_h.print();
    dma_common::gen2bfm.put(tx_h);
    
    tx_h = new();
    tx_h.randomize with() {addr == `CH0_CMD_REG1;wr_rd==1;data==32'h2000_0000;};
    tx_h.print();
    dma_common::gen2bfm.put(tx_h);
    
    tx_h = new();
    tx_h.randomize with() {addr == `CH0_CMD_REG2;wr_rd==1;data==32'd128;};
    tx_h.print();
    dma_common::gen2bfm.put(tx_h);
    
    tx_h = new();
    data_t = {28'b0,2'b0,1'b1,1'b1};
    tx_h.randomize with() {addr == `CH0_CMD_REG3;wr_rd==1;data==data_t;};
    dma_common::gen2bfm.put(tx_h);
  endtask
  
  task configure_interupt_controller;
    tx_h = new();
    data_t = 13'h1FFF;
    tx_h.randomize() with {addr == `CH0_INT_ENABLE_REG;wr_rd == 1; data==data_t;};
    dma_common::gen2bfm.put(tx_h);
  endtask
  task enable_channel;
    tx_h = new();
    tx_h.randomize() with {addr == `CH0_CH_ENABLE_REG;wr_rd == 1;data==32'h1;};
    dma_common::gen2bfm.put(tx_h);
  endtask
  task start_channel;
    tx_h = new();
    tx_h.randomize() with {addr ==`CH0_CH_START_REG;wr_rd==1;data==32'h1;};
    dma_common::gen2bfm.put(tx_h);
  endtask
endclass
