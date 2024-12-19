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
endclass
