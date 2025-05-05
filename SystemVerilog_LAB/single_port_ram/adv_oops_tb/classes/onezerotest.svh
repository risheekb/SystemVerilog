class OneZeroTest extends BaseTest;
  
  function new(virtual ram_interface vif);
    super.new(vif);
  endfunction

  virtual task run(int n);
    $display("Writing OneZeroTransactions ...");
    gen_h.blueprint_h = OneZero::new();
    super.run(n);
  endtask

endclass
