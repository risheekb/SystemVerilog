package instr_register_test;
  import instr_register_pkg::*;
  export instr_register_pkg::*;
  
  typedef class Transaction;
  typedef class DivideBy0;
  typedef class Div0Test;
  typedef class Driver;
  typedef class Generator;
  typedef class Monitor;
  typedef class Scoreboard;
  typedef class BaseTest;
  typedef class Component;
  typedef class BothTest;

  `include "classes/transaction.svh"
  `include "classes/component.svh"
  `include "classes/divideby0.svh"
  `include "classes/div0test.svh"
  `include "classes/driver.svh"
  `include "classes/generator.svh"
  `include "classes/monitor.svh"
  `include "classes/scoreboard.svh"
  `include "classes/basetest.svh"
  `include "classes/bothtest.svh"


  BaseTest test_h;

  
  task run_test(virtual instr_register_inf io);
    string test_name;
    if($value$plusargs("testname=%s",test_name))
      $display("Found +testname=%s",test_name);
    else
      $fatal(0,"Must run with +testname=test switch");
    case(test_name) 
      "BaseTest": test_h = BaseTest::new(io);
      "Div0Test": test_h = Div0Test::new(io);
      "BothTest": test_h = BothTest::new(io);
      default: $display("Test Not Recognized");
    endcase
    
    $display("Running test $test",test_name);
    test_h.build();
    test_h.reset();
    test_h.run(DEPTH);
    if(test_name != "BothTest")
      test_h.check(DEPTH);
    $finish();
  endtask

endpackage
