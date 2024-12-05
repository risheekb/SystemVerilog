package fifo_tst_pkg;

  import fifo_pkg::*;
  export fifo_pkg::*;

  typedef class Transaction;
  typedef class TransOne;
  typedef class TransZero;
  typedef class Component;
  typedef class Driver;
  typedef class Stimulus;
  typedef class Monitor;
  typedef class Scoreboard;
  typedef class Predictor;
  typedef class Coverage;
  typedef class BaseTest;
  typedef class FullTest;
  typedef class EmptyTest;
  typedef class ClearTest;
  typedef class OneTest;
  typedef class InvalidTest;

  `include "classes/component.svh"
  `include "classes/transaction.svh"
  `include "classes/transone.svh"
  `include "classes/transzero.svh"
  `include "classes/driver.svh"
  `include "classes/stimulus.svh"
  `include "classes/monitor.svh"
  `include "classes/scoreboard.svh"
  `include "classes/predictor.svh"
  `include "classes/coverage.svh"
  `include "classes/basetest.svh"
  `include "classes/fulltest.svh"
  `include "classes/emptytest.svh"
  `include "classes/cleartest.svh"
  `include "classes/onetest.svh"
  `include "classes/invalidtest.svh"

  BaseTest test_h;


  task run_test(virtual fifo_inf vif);
    
    string test_name;
 if($value$plusargs("test=%s",test_name))
      $display("Found +test=%s",test_name);
    else
      $fatal(0,"MUST RUN WITH +test SWITCH ..");
    case(test_name)
      "BaseTest": test_h = BaseTest::new(vif);
      "FullTest": test_h = FullTest::new(vif);
      "EmptyTest": test_h = EmptyTest::new(vif);
      "ClearTest": test_h = ClearTest::new(vif);
      "OneTest": test_h = OneTest::new(vif);
      "InvalidTest": test_h = InvalidTest::new(vif);
      "All": begin
        $display("\n\t:::: Starting BaseTest...\n");
        test_h = BaseTest::new(vif);
        execute(test_h);
        $display("\n\t:::: Starting FullTest...\n");
        test_h = FullTest::new(vif);
        execute(test_h);
        $display("\n\t:::: Starting ClearTest...\n");
        test_h = ClearTest::new(vif);
        execute(test_h);
        $display("\n\t:::: Starting EmptyTest...\n");
        test_h = EmptyTest::new(vif);
        execute(test_h);
        $display("\n\t:::: Starting OneTest...\n");
        test_h = OneTest::new(vif);
        execute(test_h);
        $display("\n\t :::: Starting InvalidTest...\n");
        test_h = InvalidTest::new(vif);
        execute(test_h);
      end
      default: $display("TestCase Not Found ...");
    endcase
    if(test_name != "All")
      execute(test_h);
    #100;
    $stop;
  endtask

  task execute(BaseTest test_h);
    test_h.build();
    test_h.reset();
    test_h.run(DEPTH);
    test_h.check(DEPTH);
    test_h.report();
  endtask
endpackage
