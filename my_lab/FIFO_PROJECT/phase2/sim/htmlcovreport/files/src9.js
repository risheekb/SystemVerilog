var g_data = {"name":"../rtl/classes/driver.svh","src":"class Driver extends Component;\n\n  virtual fifo_inf vif;\n  mailbox #(Transaction) stim2drv_h;\n\n  function new(virtual fifo_inf vif);\n    this.vif = vif;\n  endfunction\n\n  virtual task reset();\n    $display(\"Applying reset to the FIFO...\");\n    vif.reset <= 1;    //async reset\n    repeat(3) @(posedge vif.clk);\n    vif.reset <= 0;\n\n    vif.clear = 1'b0;\n    vif.read = 1'b0;\n    vif.write = 1'b0;\n    vif.data_in = '0;\n  endtask\n\n  virtual task run(int n);\n    repeat(n) begin\n      Transaction trans_h;\n      stim2drv_h.get(trans_h);\n      send_transaction(trans_h);\n    end\n  endtask\n\n  virtual task run_invalid(int n);\n    repeat(n) begin\n      Transaction trans_h;\n      stim2drv_h.get(trans_h);\n      send_invalid(trans_h);\n    end\n  endtask\n\n  virtual task send_transaction(Transaction trans_h);\n    @(posedge vif.clk);\n    vif.data_in = trans_h.data;\n    vif.write = 1'b1;\n    vif.read = 1'b0;\n    @(posedge vif.clk);\n    vif.write = 1'b0;\n  endtask\n\n  virtual task send_invalid(Transaction trans_h);\n    @(posedge vif.clk);\n    vif.data_in = trans_h.data;\n    vif.write = 1'b1;\n    vif.read = 1'b1;\n    @(posedge vif.clk);\n    vif.write = 1'b0;\n    vif.read = 1'b0;\n  endtask\n\n  virtual task check(int n);\n    repeat(n) begin\n      Transaction trans_h;\n      stim2drv_h.get(trans_h);\n      check_transaction(trans_h);\n    end\n  endtask\n  \n  virtual task check_invalid(int n);\n    repeat(n) begin\n      check_invalid_transaction();\n    end\n  endtask\n  \n  virtual task check_transaction(Transaction trans_h);\n    @(posedge vif.clk);\n    vif.read = 1'b1;\n    vif.write = 1'b0;\n    @(posedge vif.clk);\n    vif.read = 1'b0;\n    #5;\n    //wait(vif.data_out);\n    trans_h.data = vif.data_out;\n  endtask\n\n  virtual task check_invalid_transaction();\n    @(posedge vif.clk);\n    vif.read = 1'b1;\n    vif.write = 1'b1;\n    @(posedge vif.clk);\n    vif.read = 1'b0;\n    vif.write = 1'b0;\n\n  endtask\n\n  virtual task clear();\n    @(posedge vif.clk);\n    vif.clear = 1'b1;\n    @(posedge vif.clk);\n    vif.clear = 1'b0;\n  endtask\n\nendclass\n","lang":"verilog"};
processSrcData(g_data);