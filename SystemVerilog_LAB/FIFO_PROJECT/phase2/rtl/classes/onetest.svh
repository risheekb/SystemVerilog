class OneTest extends BaseTest;

  function new(virtual fifo_inf vif);
    super.new(vif);
  endfunction

  virtual task run(int n);
    stim_h.blueprint_h = TransOne::new();
    super.run(n);
  endtask

endclass
