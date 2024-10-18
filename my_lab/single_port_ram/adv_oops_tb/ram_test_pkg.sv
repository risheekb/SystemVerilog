package ram_test_pkg;
  import ram_pkg::*;
  export ram_pkg::*;

  typedef class Transaction;
  typedef class TransOne;
  typedef class Driver;
  typedef class Component;
  typedef class Generator;
  typedef class Scoreboard;
  typedef class Monitor;
  typedef class BaseTest;
  typedef class OneTest;
  typedef class BothTest;
  `include "classes/transaction.svh"
  `include "classes/transone.svh"
  `include "classes/driver.svh"
  `include "classes/component.svh"
  `include "classes/generator.svh"
  `include "classes/scoreboard.svh"
  `include "classes/monitor.svh"
  `include "classes/basetest.svh"
  `include "classes/onetest.svh"
  `include "classes/bothtest.svh"
  
  BaseTest test_h;
  int n = DEPTH;

  task run_test(virtual ram_interface vif);
    string test_name;

    if($value$plusargs("TEST_NAME=%s",test_name))
      $display("Found +TEST_NAME=%s",test_name);
    else
      $fatal(0,"MUST RUN WITH +TEST_NAME SWITCH ..");
    case(test_name)
      "BaseTest": test_h = BaseTest::new(vif);
      "OneTest": test_h = OneTest::new(vif);
      "BothTest": test_h = BothTest::new(vif);
      default: $display("TestCase Not Found ...");
    endcase
    test_h.build();
    test_h.reset();
    test_h.run(DEPTH);
    test_h.check(DEPTH);
    test_h.report();
    $finish;
  endtask


endpackage
