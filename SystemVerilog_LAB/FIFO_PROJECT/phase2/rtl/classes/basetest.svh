class BaseTest extends Component;

  virtual fifo_inf vif;
  
  Stimulus stim_h;
  Driver drv_h;
  Monitor mon_h;
  Scoreboard scbd_h;
  Predictor pred_h;
  Coverage cov_h;

  mailbox #(Transaction) stim2drv_h,mon_in_h,pred2scbd_h,mon_out_h;

  function new(virtual fifo_inf vif);
    this.vif = vif;
  endfunction

  virtual task build;
    drv_h = new(vif);  //TB components
    stim_h = new();
    pred_h = new();
    scbd_h = new();
    mon_h = new(vif);
    cov_h = new(vif);

    stim2drv_h = new(1); // Mailboxes for connecting the TB components
    mon_in_h = new();
    pred2scbd_h = new();
    mon_out_h = new();

    stim_h.stim2drv_h = stim2drv_h;
    drv_h.stim2drv_h = stim2drv_h;

    mon_h.mon_in_h = mon_in_h;
    mon_h.mon_out_h = mon_out_h;
    pred_h.mon_in_h = mon_in_h;
    pred_h.pred2scbd_h = pred2scbd_h;
    scbd_h.pred2scbd_h = pred2scbd_h;
    scbd_h.mon_out_h = mon_out_h;

    stim_h.build();
  endtask

  virtual task reset;
    stim_h.reset();
    drv_h.reset();
    mon_h.reset();
    pred_h.reset();
    scbd_h.reset();
  endtask

  virtual task run(int n);
    fork
      cov_h.run(n);
      stim_h.run(n);
      drv_h.run(n);
      mon_h.run(n);
      pred_h.run(n);
      scbd_h.run(n);
    join
  endtask
  
  virtual task check(int n);
    fork
      //cov_h.run(n);
      stim_h.check(n);
      drv_h.check(n);
      mon_h.check(n);
      pred_h.check(n);
      scbd_h.check(n);
    join
  endtask
  virtual task report();
    fork
      stim_h.report();
      drv_h.report();
      mon_h.report();
      pred_h.report();
      scbd_h.report();
      //cov_h.run(0);
    join_none
  endtask
endclass
