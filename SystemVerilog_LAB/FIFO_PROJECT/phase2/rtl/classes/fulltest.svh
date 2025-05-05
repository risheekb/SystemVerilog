class FullTest extends BaseTest;
  
  function new(virtual fifo_inf vif);
    super.new(vif);
  endfunction

  virtual task run(int n);
    fork
      stim_h.run(2*n);
      drv_h.run(2*n);
      mon_h.run(n);
      pred_h.run(n);
      scbd_h.run(n);
    join
  endtask
endclass
