class axi_common;
  static mailbox gen2bfm = new();
  static mailbox mon2scb = new();
  static virtual  axi_inf vif;
  static string testname;
  static int tx_count = 10;
  static int total_driven_tx_count=0;
  static int total_gen_tx_count=0;
endclass
