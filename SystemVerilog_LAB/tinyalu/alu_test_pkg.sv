package alu_test_pkg;
  import alu_pkg::*;
  export alu_pkg::*;
  
  typedef class Component;
  typedef class Transaction;
  typedef class MULTransaction;
  typedef class Driver;
  typedef class Generator;
  typedef class Monitor;
  typedef class Scoreboard;
  typedef class BaseTest;
  typedef class MULTest;

  `include "classes/component.svh"
  `include "classes/transaction.svh"
  `include "classes/multransaction.svh"
  `include "classes/driver.svh"
  `include "classes/generator.svh"
  `include "classes/monitor.svh"
  `include "classes/scoreboard.svh"
  `include "classes/basetest.svh"
  `include "classes/multest.svh"

  BaseTest test_h;


  task run_test(virtual alu_interface vif);
    string testname;
   
    if ($value$plusargs("testname=%s", testname))
      $display("Found +testname=%s", testname);
    else
      $fatal(0, "Must run with +testname=test switch");
    case(testname)
      "BaseTest": test_h = BaseTest::new(vif);
      "MULTest":  test_h = MULTest::new(vif);
    endcase
    //test_h = new(vif);
    test_h.build();
    $display("Applying Reset To The Dut");
    test_h.reset();
    $display("Starting The Run Phase");
    test_h.run(100);
    $display("Starting The Check Phase");
    test_h.check(100);
    test_h.report();
    #20;
    $finish;
  endtask
endpackage
