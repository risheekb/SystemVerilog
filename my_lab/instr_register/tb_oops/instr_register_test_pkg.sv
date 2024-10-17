package instr_register_test;
  import instr_register_pkg::*;
  export instr_register_pkg::*;
  
  typedef class Transaction;
  typedef class Driver;
  typedef class Generator;
  typedef class Monitor;
  typedef class Scoreboard;
  typedef class BaseTest;

  `include "classes/transaction.svh"
  `include "classes/driver.svh"
  `include "classes/generator.svh"
  `include "classes/monitor.svh"
  `include "classes/scoreboard.svh"
  `include "classes/basetest.svh"


  BaseTest test_h;
  

  
 task run_test(virtual instr_register_inf io);
  test_h = new(io);
  test_h.run(DEPTH);
  $finish();
  endtask

endpackage
