module tb_basic
  import alu_pkg::*;
  (alu_interface inf); 
  typedef class Transaction;

  `include "classes/transaction.svh"
  result_t result_expected;
  Transaction expect_q[$];
  Transaction trans;
  initial begin
    @(posedge inf.clk)
    inf.reset_n <= 1'b0;
    repeat(5) @(posedge inf.clk);
    inf.reset_n <= 1'b1;

    repeat(100) begin
      fork
        send_transaction();
        check_transaction();
      join
    end
    #100;
    $finish;
  end

    task send_transaction();
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
    endtask

    task check_transaction;
      while(expect_q.size() != 0) begin
        //trans.copy(expect_q.pop_front());
      wait(inf.done)#1ns;
      case(expect_q.pop_front().opcode)
        //case(trans.opcode)
        NOP: begin
          if(inf.result !== 'z)
            $error("mismatch for NOP");
        end
        ADD: begin
          result_expected = inf.A + inf.B;
          if(inf.result != result_expected) begin
            $error("mismatch for ADD");
            $strobe("@%0t mismatch for ADD expected = %0d actual = %0d",$realtime,result_expected,inf.result);
          end
        end
        SUB: begin
          result_expected = inf.A - inf.B;
          if(inf.result != result_expected) begin
            $error();
            $strobe("@%0t mismatch for SUB expected = %0d actual = %0d",$realtime,result_expected,inf.result);
          end
        end
        NOT: begin
          result_expected = ~inf.A;
          if(inf.result != result_expected)begin
            $error("mismatch for NOT");
            $strobe("@%0t mismatch for NOT expected = %0d actual = %0d",$realtime,result_expected,inf.result);
          end
        end
        XOR: begin
          result_expected = inf.A ^ inf.B;
          if(inf.result != result_expected) begin
            $error("mismatch for XOR");
            $strobe("@%0t mismatch for XOR expected = %d actual = %d",$realtime,result_expected,inf.result);
          end
        end
        AND: begin
          result_expected = inf.A & inf.B;
          if(inf.result != result_expected)begin
            $error("mismatch for AND");
            $strobe("@%0t mismatch for AND expected = %d actual = %d",$realtime,result_expected,inf.result);
          end
        end
        MUL: begin
          result_expected = inf.A * inf.B;
          if(inf.result != result_expected) begin
            $error("mismatch for MUL");
            $strobe("@%0t mismatch for MUL expected = %d actual = %d",$realtime,result_expected,inf.result);
          end
        end
        INC: begin
          result_expected =inf.A+inf.B+1'b1;
          if(inf.result != result_expected) begin 
            $error("mismatch for INC");
            $strobe("@%0t mismatch for INC expected = %d actual = %d",$realtime,result_expected,inf.result);
          end
        end
        
      endcase
      end
    endtask

  initial begin
    $monitor("%0t A = %0d B = %0d reset_n = %0d start = %0d opcode = %s done = %0d result = %0d",$realtime,inf.A,inf.B,inf.reset_n,inf.start,inf.opcode,inf.done,inf.result);
  end
endmodule
