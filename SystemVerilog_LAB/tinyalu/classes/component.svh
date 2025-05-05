class Component;
  virtual task reset;
  endtask

  virtual task build;
  endtask
  
  virtual task run(int n);
  endtask

  virtual task check(int n);
  endtask
  
  virtual task report;
  endtask

endclass
