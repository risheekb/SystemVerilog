module tb_basic_2
  import alu_pkg::*;
  (alu_interface inf); 
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
  result_t result_expected;
  Transaction expect_q[$];
  Transaction trans;
  int n = 10;
  initial begin
    @(posedge inf.clk)
    inf.reset_n <= 1'b0;
    repeat(5) @(posedge inf.clk);
    inf.reset_n <= 1'b1;

        send_transaction(n);
        check_transaction(n);
    #100;
    $finish;
  end

    task send_transaction(int n);
      repeat(n) begin
        trans = new();
        trans.randomize_transaction();
        @(posedge inf.clk) #1ns;
        inf.start = 1'b1;
        inf.A = trans.A;
        inf.B = trans.B;
        inf.opcode = trans.opcode;
        wait(inf.done)
        inf.start = 1'b0;
        trans.result = inf.result;
        expect_q.push_back(trans);
      end
    endtask

    task check_transaction(int n);
      foreach(expect_q[i]) begin
        //trans.copy(expect_q.pop_front());
        trans = new();
        trans = expect_q[i];
      wait(inf.done)#1ns;
      case(trans.opcode)
        //case(trans.opcode)
        NOP: begin
          if(trans.result !== 'z)
            $error("mismatch for NOP");
        end
        ADD: begin
          result_expected = trans.A + trans.B;
          if(trans.result != result_expected) begin
            $error("mismatch for ADD");
            $strobe("@%0t mismatch for ADD expected = %0d actual = %0d",$realtime,result_expected,trans.result);
          end
        end
        SUB: begin
          result_expected = trans.A - trans.B;
          if(trans.result != result_expected) begin
            $error();
            $strobe("@%0t mismatch for SUB expected = %0d actual = %0d",$realtime,result_expected,trans.result);
          end
        end
        NOT: begin
          result_expected = ~trans.A;
          if(trans.result != result_expected)begin
            $error("mismatch for NOT");
            $strobe("@%0t mismatch for NOT expected = %0d actual = %0d",$realtime,result_expected,trans.result);
          end
        end
        XOR: begin
          result_expected = trans.A ^ trans.B;
          if(trans.result != result_expected) begin
            $error("mismatch for XOR");
            $strobe("@%0t mismatch for XOR expected = %d actual = %d",$realtime,result_expected,trans.result);
          end
        end
        AND: begin
          result_expected = trans.A & trans.B;
          if(trans.result != result_expected)begin
            $error("mismatch for AND");
            $strobe("@%0t mismatch for AND expected = %d actual = %d",$realtime,result_expected,trans.result);
          end
        end
        MUL: begin
          result_expected = trans.A * trans.B;
          if(trans.result != result_expected) begin
            $error("mismatch for MUL");
            $strobe("@%0t mismatch for MUL expected = %d actual = %d",$realtime,result_expected,trans.result);
          end
        end
        INC: begin
          result_expected =trans.A+trans.B+1'b1;
          if(trans.result != result_expected) begin 
            $error("mismatch for INC");
            $strobe("@%0t mismatch for INC expected = %d actual = %d",$realtime,result_expected,trans.result);
          end
        end
      endcase
      end
    endtask

  initial begin
    $monitor("%0t A = %0d B = %0d reset_n = %0d start = %0d opcode = %s done = %0d result = %0d",$realtime,inf.A,inf.B,inf.reset_n,inf.start,inf.opcode,inf.done,inf.result);
  end
endmodule
