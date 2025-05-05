class EmptyTest extends BaseTest;

  function new(virtual fifo_inf vif);
    super.new(vif);
  endfunction

  virtual task run(int n);
    //Try to read the FIFO while it is empty 
  endtask

  virtual task check(int n);
    fork
      stim_h.check(n);
      drv_h.check(n);
    join
  endtask

endclass
