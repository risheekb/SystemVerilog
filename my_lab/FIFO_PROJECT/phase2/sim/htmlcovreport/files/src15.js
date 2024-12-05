var g_data = {"name":"../rtl/classes/fulltest.svh","src":"class FullTest extends BaseTest;\n  \n  function new(virtual fifo_inf vif);\n    super.new(vif);\n  endfunction\n\n  virtual task run(int n);\n    fork\n      stim_h.run(2*n);\n      drv_h.run(2*n);\n      mon_h.run(n);\n      pred_h.run(n);\n      scbd_h.run(n);\n    join\n  endtask\nendclass\n","lang":"verilog"};
processSrcData(g_data);