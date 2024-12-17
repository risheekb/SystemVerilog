class apb_env;
  apb_bfm apb_bfm_h;
  apb_gen apb_gen_h;
  apb_mon apb_mon_h;
  apb_cov apb_cov_h;

  function new();
    apb_bfm_h = new();
    apb_gen_h = new();
    apb_mon_h = new();
    apb_cov_h = new();
  endfunction

  task run;
    apb_bfm_h.run();
    apb_gen_h.run();
    apb_mon_h.run();
    apb_cov_h.run();
  endtask

endclass
