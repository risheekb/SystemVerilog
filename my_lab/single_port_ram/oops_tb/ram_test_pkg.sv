package ram_test_pkg;
  import ram_pkg::*;
  export ram_pkg::*;

  typedef class Transaction;
  typedef class Driver;
  typedef class Generator;
  typedef class Scoreboard;
  typedef class Monitor;
  typedef class BaseTest;
  `include "classes/transaction.svh"
  `include "classes/driver.svh"
  `include "classes/generator.svh"
  `include "classes/scoreboard.svh"
  `include "classes/monitor.svh"
  `include "classes/basetest.svh"
  
  BaseTest test_h;
  int n = DEPTH;

  task run_test(virtual ram_interface vif);
  test_h = new(vif);
  
  test_h.run(DEPTH);
  test_h.check(DEPTH);
  $finish;
  endtask


endpackage
