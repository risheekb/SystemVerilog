class ClearTest extends BaseTest;

  function new(virtual fifo_inf vif);
    super.new(vif);
  endfunction


  virtual task run(int n);
    fork
      stim_h.run(n);
      drv_h.run(n);
    join
    drv_h.clear();
    super.run(n);
  endtask


endclass
