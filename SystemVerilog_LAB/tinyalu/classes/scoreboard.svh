class Scoreboard extends Component;
  Transaction expect_q[$];

  mailbox #(Transaction) mon_in_h,mon_out_h;

  virtual task run(int n);
    repeat(n) begin
      Transaction trans_h;
      mon_in_h.get(trans_h);
      add_input(trans_h);
    end
  endtask

  task add_input(Transaction trans); //task to add to the expect q;
    expect_q.push_back(trans);
  endtask

  virtual task check(int n);
    Transaction trans_h;
    mon_out_h.get(trans_h);
    check_output();
  endtask

  task check_output(); //task to compare the outputs
    Transaction trans;
    result_t result_expected;
  
    foreach(expect_q[i]) begin
      trans = new();
      trans = expect_q[i];
      case(trans.opcode)
        NOP: begin
          if(trans.result !== 'z)
            $error("@%0t :: mismatch for NOP expected = %0d actual = %0d",$realtime,result_expected,trans.result);
          else 
            $display("@%0t %m PASS %p",$realtime,trans);
        end
        ADD: begin
          result_expected = trans.A + trans.B;
          if(trans.result != result_expected) begin
            $error("@%0t :: mismatch for ADD expected = %0d actual = %0d",$realtime,result_expected,trans.result);
          end
          else 
            $display("@%0t %m PASS %p",$realtime,trans);
        end
        SUB: begin
          result_expected = trans.A - trans.B;
          if(trans.result != result_expected) begin
            $error("@%0t :: mismatch for SUB expected = %0d actual = %0d",$realtime,result_expected,trans.result);
          end
          else 
            $display("@%0t %m PASS %p",$realtime,trans);
        end
        NOT: begin
          result_expected = ~trans.A;
          if(trans.result != result_expected)begin
            $error("@%0t :: mismatch for NOT expected = %0d actual = %0d",$realtime,result_expected,trans.result);
          end
          else 
            $display("@%0t %m PASS %p",$realtime,trans);
        end
        XOR: begin
          result_expected = trans.A ^ trans.B;
          if(trans.result != result_expected) begin
            $error("@%0t :: mismatch for XOR expected = %0d actual = %0d",$realtime,result_expected,trans.result);
          end
          else 
            $display("@%0t %m PASS %p",$realtime,trans);
        end
        AND: begin
          result_expected = trans.A & trans.B;
          if(trans.result != result_expected)begin
            $error("@%0t :: mismatch for AND expected = %0d actual = %0d",$realtime,result_expected,trans.result);
          end
          else 
            $display("@%0t %m PASS %p",$realtime,trans);
        end
        MUL: begin
          result_expected = trans.A * trans.B;
          if(trans.result != result_expected) begin
            $error("@%0t :: mismatch for MUL expected = %0d actual = %0d",$realtime,result_expected,trans.result);
          end
          else 
            $display("@%0t %m PASS %p",$realtime,trans);
        end
        INC: begin
          result_expected =trans.A+trans.B+1'b1;
          if(trans.result != result_expected) begin 
            $error("@%0t :: mismatch for INC expected = %0d actual = %0d",$realtime,result_expected,trans.result);
          end
          else 
            $display("@%0t %m PASS %p",$realtime,trans);
        end
      endcase
    end
  endtask
endclass
