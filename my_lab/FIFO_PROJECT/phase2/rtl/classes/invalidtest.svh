class InvalidTest extends BaseTest;

  function new(virtual fifo_inf vif);
    super.new(vif);
  endfunction

  virtual task run(int n);
    fork
      stim_h.run(n);
      drv_h.run_invalid(n);
      mon_h.run(n);
      pred_h.run(n);
      scbd_h.run(n);
    join
  endtask

  virtual task check(int n);
    fork
      drv_h.check_invalid(n);
    join
  endtask
endclass
