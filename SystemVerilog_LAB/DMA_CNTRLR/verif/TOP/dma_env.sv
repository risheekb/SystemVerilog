class dma_env;

  apb_env apb_env_h;
  axi_env axi_env_h;
  dma_ref dma_ref_h;
  dma_ckr dma_ckr_h;

  function new();

    apb_env_h = new();
    axi_env_h = new();
    dma_ckr_h = new();
    dma_ref_h = new();
  endfunction

  task run;
    fork
      apb_env_h.run();
      axi_env_h.run();
      dma_ckr_h.run();
      dma_ref_h.run();
    join
  endtask

endclass
