class Component;

  /*
  * UVM Style component class
  * Tasks/Functions:
  *   ->reset: reset(phase) functionality is defined here.
  *     arg: None.
  *
  *   ->build: build(phase) objects are constructed here.
  *     arg: None.
  *
  *   ->run: run(phase) starts generating stimulus here. 
  *     arg: int n.
  *
  *   ->check: check(phase) evaluation of the data output.
  *   arg: int n.
  *
  *   ->report: report(phase) reporting is done here.
  */

  virtual task reset;
  endtask

  virtual task build;
  endtask

  virtual task run(int n);
  endtask

  virtual task check(int n);
  endtask

  virtual task report();
  endtask

endclass
