class OneTest extends BaseTest;
  function new(virtual ram_interface vif);
    super.new(vif);
  endfunction

  virtual task run(int n);
    $display("Writing OneTransactions ..");
    gen_h.blueprint_h = TransOne::new();
    super.run(n);
  endtask

endclass
