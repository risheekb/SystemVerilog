class dma_common;
  `include"dma_addr.h"
  static virtual apb_inf apb_vif;
  static virtual axi_inf axi_vif;
  static virtual periph_inf periph_vif;
  static  mailbox mon2cov = new();
  static mailbox apbmon2ref = new();
  static mailbox aximon2ref = new();
  static mailbox gen2bfm = new();
  static string test_name;
  static int txn_gen = -1;
  static int txn_driv;
  static int ch_count = 8;
  static bit dut_reset_applied;
  static int error_count;
  static int data_mismatch;
  static int data_match;
  static bit[31:0] cmd_addr_t;
  typedef enum{
    LOW,
    HIGH
  } level;

  function new();
    for(int i = 0;i<ch_count;i++) begin
      //STATIC_REG0
      rd_burst_max_size_a  [i] = 10'd128;
      rd_allow_full_burst_a[i] = 1'b0;
      rd_allow_full_fifo_a [i] = 1'b1;
      rd_tokens_a[i]           = 6'h1; 
      rd_outs_max_a[i]         = 4'h4;
      rd_outstanding_a[i]      = 1'b0;
      rd_incr_a[i]             = 1'b1;
      //STATIC_REG1
      wr_burst_max_size_a  [i] = 10'd128;
      wr_allow_full_burst_a[i] = 1'b0;
      wr_allow_full_fifo_a [i] = 1'b1;
      wr_tokens_a[i]           = 6'h1; 
      wr_outs_max_a[i]         = 4'h4;
      wr_outstanding_a[i]      = 1'b0;
      wr_incr_a[i]             = 1'b1;

      rd_addr_a[i]             = `CH0_RD_START+32'h1_0000*i;
      wr_addr_a[i]             = `CH0_WR_START+ 32'h1_0000*i;

      if(test_name == "test_all_ch") buffer_size_a[i] = 32'd32;
      else buffer_size_a[i] = 32'd128;
      x_size_a[i] = 0;
      y_size_a[i] = 0;

      cmd_set_int_a[i] = 1'b1;
      cmd_last_a[i] =    1'b1;
      cmd_next_addr_a[i] = 28'b0;

      int_enable_ch_end_a[i] = 1'b1;
      int_enable_rd_decerr_a[i] = 1'b1;
      int_enable_rd_slverr_a[i] = 1'b1;
      int_enable_wr_decerr_a[i] = 1'b1;
      int_enable_wr_slverr_a[i] = 1'b1;
      int_enable_overflow_a[i] = 1'b1;
      int_enable_underflow_a[i] = 1'b1;
      int_enable_timeout_r_a[i] = 1'b1;
      int_enable_timeout_ar_a[i] = 1'b1;
      int_enable_timeout_b_a[i] = 1'b1;
      int_enable_timeout_w_a[i] = 1'b1;
      int_enable_timeout_aw_a[i] = 1'b1;
      int_enable_wdt_a[i] = 1'b1;
      if(test_name == "test_cmd_list") begin
          cmd_last_a[0] = 0;
          cmd_addr_t = `CMD1_ADDR;
          cmd_addr_t >>= 4;
          cmd_next_addr_a[0] = cmd_addr_t;
      end
      //STATIC_REG2
      frame_width_a[i] = 0;
      block_a[i] = 0;
      joint_a[i] = 0;
      auto_retry_a[i] = 0;
      rd_cmd_port_num_a[i] = 0;
      rd_port_num_a[i] = 0;
      wr_port_num_a[i] = 0;
      int_num_a[i] = 0;
      end_swap_a[i] = 0;
      //STATIC REG3
      rd_wait_limit_a[i] = 0;
      wr_wait_limit_a[i] = 0;
      //STATIC REG4
      rd_periph_num_a[i] = 0;
      rd_periph_delay_a[i] = 0;
      rd_periph_block_a[i] = 0;
      wr_periph_num_a[i] = 0;
      wr_periph_delay_a[i] = 0;
      wr_periph_block_a[i] = 0;
      if(test_name == "test_periph_transfer") begin
        rd_periph_num_a[0] = 1; //reading from perpipheral 1
        wr_periph_num_a[0] = 2;//writing to peripheral 2
        rd_periph_delay_a[0] = 3;
        wr_periph_delay_a[0] = 3;
      end
    end
    $display("test_name = %s",test_name);
    $display("buffer size = %p",buffer_size_a);
  endfunction

endclass
