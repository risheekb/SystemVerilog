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

      rd_addr_a[i]             = 32'h1000_0000 + 32'h1_0000*i;
      wr_addr_a[i]             = 32'h2000_0000 + 32'h1_0000*i;

      buffer_size_a[i] = 32'd128; 
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
      
    end

  endfunction

endclass
