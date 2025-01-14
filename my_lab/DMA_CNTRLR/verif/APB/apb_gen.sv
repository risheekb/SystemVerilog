class apb_gen;
  apb_tx tx_h;
  bit [31:0] data_t;
  task run();
    $display("apb_gen::run");
    case(dma_common::test_name)
      "test_periph_transfer":begin
        general_config();
        configure_start_ch(0);
      end
      "test_cmd_list":begin
        general_config();
        //preload the memory with commands
        configure_start_ch(0);
      end
      "test_ch0_sanity":begin
        //configure and start the channel
        //section general configuration
        general_config();
        configure_start_ch(0);
      end
      "test_all_ch": begin
        general_config();
        for(int i =0;i<dma_common::ch_count;i++) configure_start_ch(i);
      end
      "test_reg_reset": begin
        for(int j = 0;j<=7;j++) begin
        //from CH0_CMD_REG0 till CH0_COUNT_REG  
          for(int i = 0;i<=20;i++) begin
            if(i == 19|| i == 9 || i == 10 || i == 17) continue;
            tx_h = new();
            tx_h.randomize() with {addr == 13'h100*j+ 4*i; wr_rd ==0;};
            //tx_h.print();
            dma_common::gen2bfm.put(tx_h);
          end
          //for A0 to AC
          for(int i = 40; i<=43;i++) begin
            if(i == 41) continue;
            tx_h = new();
            tx_h.randomize() with {addr ==13'h100*j+i*4;wr_rd ==0;};
            //tx_h.print();
            dma_common::gen2bfm.put(tx_h);
          end
        end
        //shared registers
        for(int i = 0; i<=7;i++) begin
          if(i > 0) continue;
          tx_h = new();
          tx_h.randomize() with {addr == 13'h1000 +i*4;wr_rd ==0;};
          //tx_h.print();
          dma_common::gen2bfm.put(tx_h);
        end
        for(int i = 12; i<=21;i++) begin
          if(i == 13 || i == 15 || i == 17 || i == 18 || i == 19) continue;
          tx_h = new();
          tx_h.randomize() with {addr == 13'h1000 +i*4;wr_rd ==0;};
          //tx_h.print();
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
            //tx_h.print();
            dma_common::gen2bfm.put(tx_h);
          end
          //for A0 to AC
          for(int i = 40; i<=43;i++) begin
            if(i == 43) continue;
            tx_h = new();
            tx_h.randomize() with {addr ==13'h100*j+i*4;wr_rd ==1;};
            //tx_h.print();
            dma_common::gen2bfm.put(tx_h);
          end
        end
        for(int i = 12; i<=21;i++) begin
          if(i == 13 || i == 15 || i == 17 ||  i == 19) continue;
          tx_h = new();
          tx_h.randomize() with {addr == 13'h1000 +i*4;wr_rd ==1;};
          //tx_h.print();
          dma_common::gen2bfm.put(tx_h);
        end
        //READING ALL THE REGISTERS
        for(int j = 0;j<=7;j++) begin
        //from CH0_CMD_REG0 till CH0_COUNT_REG  
          for(int i = 0;i<=20;i++) begin
            if(i == 19|| i == 9 || i == 10 || i == 17) continue;
            tx_h = new();
            tx_h.randomize() with {addr == 13'h100*j+ 4*i; wr_rd ==0;};
            //tx_h.print();
            dma_common::gen2bfm.put(tx_h);
          end
          //for A0 to AC
          for(int i = 40; i<=43;i++) begin
            if(i == 41) continue;
            tx_h = new();
            tx_h.randomize() with {addr ==13'h100*j+i*4;wr_rd ==0;};
            //tx_h.print();
            dma_common::gen2bfm.put(tx_h);
          end
        end
        //shared registers
        for(int i = 0; i<=7;i++) begin
          if(i > 0) continue;
          tx_h = new();
          tx_h.randomize() with {addr == 13'h1000 +i*4;wr_rd ==0;};
          //tx_h.print();
          dma_common::gen2bfm.put(tx_h);
        end
        for(int i = 12; i<=21;i++) begin
          if(i == 13 || i == 15 || i == 17 || i == 18 || i == 19) continue;
          tx_h = new();
          //tx_h.print();
          dma_common::gen2bfm.put(tx_h);
        end
      end
    endcase
  endtask
  task general_config;
    tx_h = new();
    tx_h.randomize() with {addr == `CORE0_JOINT_MODE; wr_rd ==1; data == 32'h1;};
    //tx_h.print();
    dma_common::gen2bfm.put(tx_h);
  endtask
  task configure_start_ch(int ch_count);
    //configure static registers
    configure_static_registers(ch_count);
    //configure the interrupt controller
    configure_interupt_controller(ch_count);
    //configure command
    configure_command(ch_count);
    //enable the channel
    enable_channel(ch_count);
    //start the channel
    start_channel(ch_count);
    if(dma_common::test_name == "test_periph_transfer") begin
      repeat(8);
      trigger_periph();
    end
  endtask
  task trigger_periph();
    tx_h = new();
    tx_h.randomize() with {apb_or_periph_f == PERIPH;tx_periph == 2;rx_periph == 1;};
    dma_common::gen2bfm.put(tx_h); 
  endtask
  task configure_static_registers(int i);
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
      data_t = {
        dma_common::rd_incr_a[i]
        ,dma_common::rd_outstanding_a[i]
        ,2'b0
        ,dma_common::rd_outs_max_a[i]
        ,2'b0
        ,dma_common::rd_tokens_a[i]
        ,2'b0
        ,dma_common::rd_allow_full_fifo_a[i]
        ,dma_common::rd_allow_full_burst_a[i]
        ,2'b0
        ,dma_common::rd_burst_max_size_a[i]}; 

      tx_h.randomize() with {addr == `CH0_STATIC_REG0 + 13'h100*i;wr_rd ==1;data==data_t;};
      //tx_h.print();
      dma_common::gen2bfm.put(tx_h);
      //Configure STATIC_REG1
      tx_h = new();
      data_t = {
        dma_common::wr_incr_a[i]
        ,dma_common::wr_outstanding_a[i]
        ,2'b0
        ,dma_common::wr_outs_max_a[i]
        ,2'b0
        ,dma_common::wr_tokens_a[i]
        ,2'b0
        ,dma_common::wr_allow_full_fifo_a[i]
        ,dma_common::wr_allow_full_burst_a[i]
        ,2'b0
        ,dma_common::wr_burst_max_size_a[i]}; 

      //data_t = {1'b1,1'b0,2'b0,4'h4,2'b0,6'h1,2'b0,1'b1,1'b0,2'b0,10'd128}; 
      tx_h.randomize() with {addr == `CH0_STATIC_REG1 + 13'h100*i;wr_rd ==1;data==data_t;};
      dma_common::gen2bfm.put(tx_h);
    //Configure STATIC_REG2 
    tx_h = new();
    data_t = {
      2'b0,
      dma_common::end_swap_a[i],
      1'b0,
      dma_common::int_num_a[i],
      1'b0,
      dma_common::wr_port_num_a[i],
      dma_common::rd_port_num_a[i],
      dma_common::rd_cmd_port_num_a[i],
      2'b0,
      dma_common::auto_retry_a[i],
      dma_common::joint_a[i],
      dma_common::block_a[i],
      3'b0,
      dma_common::frame_width_a[i]
    };

      tx_h.randomize() with {addr == `CH0_STATIC_REG2+ 13'h100*i;wr_rd ==1;data==data_t;};
      dma_common::gen2bfm.put(tx_h);
    //Configure STATIC_REG3
    tx_h = new();
    data_t = {
      4'b0,
      dma_common::wr_wait_limit_a[i],
      4'b0,
      dma_common::rd_wait_limit_a[i]
    };
    tx_h.randomize() with {addr == `CH0_STATIC_REG3 + 13'h100*i;wr_rd == 1; data == data_t;};
    dma_common::gen2bfm.put(tx_h);
    //Configure STATIC_REG4
    tx_h = new();
    data_t = {
      dma_common::wr_periph_block_a[i],
      4'b0,
      dma_common::wr_periph_delay_a[i],
      3'b0,
      dma_common::wr_periph_num_a[i],
      dma_common::rd_periph_block_a[i],
      4'b0,
      dma_common::rd_periph_delay_a[i],
      3'b0,
      dma_common::rd_periph_num_a[i]
    };
    tx_h.randomize() with{addr == `CH0_STATIC_REG4 + 13'h100*i;wr_rd == 1; data == data_t;};
    dma_common::gen2bfm.put(tx_h);
  endtask

  task configure_command(int i);
      tx_h = new();
      tx_h.randomize with() {addr == `CH0_CMD_REG0 +'h100*i;wr_rd==1;data==dma_common::rd_addr_a[i];};
      //tx_h.print();
      dma_common::gen2bfm.put(tx_h);

      tx_h = new();
      tx_h.randomize with() {addr == `CH0_CMD_REG1 +'h100*i;wr_rd==1;data==dma_common::wr_addr_a[i];};
      tx_h.print();
      dma_common::gen2bfm.put(tx_h);

      tx_h = new();
      tx_h.randomize with() {addr == `CH0_CMD_REG2+'h100*i;wr_rd==1;data==dma_common::buffer_size_a[i];};
      //tx_h.print();
      dma_common::gen2bfm.put(tx_h);

      tx_h = new();
      data_t = {dma_common::cmd_next_addr_a[i],2'b0,dma_common::cmd_last_a[i],dma_common::cmd_set_int_a[i]};
      tx_h.randomize with() {addr == `CH0_CMD_REG3+13'h100*i;wr_rd==1;data==data_t;};
      dma_common::gen2bfm.put(tx_h);
  endtask
  
  task configure_interupt_controller(int i);
    
      tx_h = new();
    data_t = {
      20'd0,
      dma_common::int_enable_ch_end_a[i],
      dma_common::int_enable_rd_decerr_a[i],
      dma_common::int_enable_rd_slverr_a[i],
      dma_common::int_enable_wr_decerr_a[i],
      dma_common::int_enable_wr_slverr_a[i],
      dma_common::int_enable_overflow_a[i] ,
      dma_common::int_enable_underflow_a[i],
      dma_common::int_enable_timeout_r_a[i],
      dma_common::int_enable_timeout_ar_a[i],
      dma_common::int_enable_timeout_b_a[i],
      dma_common::int_enable_timeout_w_a[i],
      dma_common::int_enable_timeout_aw_a[i],
      dma_common::int_enable_wdt_a[i]
    };

      tx_h.randomize() with {addr == `CH0_INT_ENABLE_REG+13'h100*i;wr_rd == 1; data==data_t;};
      dma_common::gen2bfm.put(tx_h);
  endtask
  task enable_channel(int i);
      tx_h = new();
      tx_h.randomize() with {addr == `CH0_CH_ENABLE_REG+13'h100*i;wr_rd == 1;data==32'h1;};
      dma_common::gen2bfm.put(tx_h);
  endtask
  task start_channel(int i);
    tx_h = new();
    tx_h.randomize() with {addr ==`CH0_CH_START_REG+13'h100*i;wr_rd==1;data==32'h1;};
    dma_common::gen2bfm.put(tx_h);
  endtask
endclass
