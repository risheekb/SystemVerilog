class BothTest extends BaseTest;
  function new(virtual ram_interface vif);
    super.new(vif);
  endfunction

  virtual task run(int n);
    $display("Running Both The Tests");
    super.run(n);
    super.check(n); //check the transactions of the first test
    gen_h.blueprint_h = TransOne::new();
    super.run(n);

  endtask

endclass
