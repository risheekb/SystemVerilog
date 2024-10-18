module tb_basic
  import alu_pkg::*;
  (output operand_t A,
    output operand_t B,
    input logic clk,
    output logic reset_n,
    output logic start,
    output opcode_t opcode,
    input result_t result,
    input logic done); 
  result_t result_expected;
  opcode_t expect_q[$];
  initial begin
    @(posedge clk)
    reset_n <= 1'b0;
    repeat(5) @(posedge clk);
    reset_n <= 1'b1;

    repeat(10) begin
      fork
        send_transaction();
        check_transaction();
      join
    end
    #100;
    $finish;
  end

    task generate_transaction;
      A = $random;
      B = $random;
      opcode = opcode_t'($urandom_range(0,7));
      expect_q.push_back(opcode);
    endtask

    task send_transaction;
      @(posedge clk) #1ns;
      start = 1'b1;
      generate_transaction();
      wait(done)
      start = 1'b0;
    endtask

    task check_transaction;
      while(expect_q.size() != 0) begin
      wait(done)#1ns;
      case(expect_q.pop_front())
        NOP: begin
          if(result !== 'z)
            $error("mismatch for NOP");
        end
        ADD: begin
          result_expected = A + B;
          if(result != result_expected) begin
            $error("mismatch for ADD");
            $strobe("@%0t mismatch for ADD expected = %0d actual = %0d",$realtime,result_expected,result);
          end
        end
        SUB: begin
          result_expected = A - B;
          if(result != result_expected) begin
            $error();
            $strobe("@%0t mismatch for SUB expected = %0d actual = %0d",$realtime,result_expected,result);
          end
        end
        NOT: begin
          result_expected = ~A;
          if(result != result_expected)begin
            $error("mismatch for NOT");
            $strobe("@%0t mismatch for NOT expected = %0d actual = %0d",$realtime,result_expected,result);
          end
        end
        XOR: begin
          result_expected = A ^ B;
          if(result != result_expected) begin
            $error("mismatch for XOR");
            $strobe("@%0t mismatch for XOR expected = %d actual = %d",$realtime,result_expected,result);
          end
        end
        AND: begin
          result_expected = A & B;
          if(result != result_expected)begin
            $error("mismatch for AND");
            $strobe("@%0t mismatch for AND expected = %d actual = %d",$realtime,result_expected,result);
          end
        end
        MUL: begin
          result_expected = A * B;
          if(result != result_expected) begin
            $error("mismatch for MUL");
            $strobe("@%0t mismatch for MUL expected = %d actual = %d",$realtime,result_expected,result);
          end
        end
        INC: begin
          result_expected =A+B+1'b1;
          if(result != result_expected) begin 
            $error("mismatch for INC");
            $strobe("@%0t mismatch for INC expected = %d actual = %d",$realtime,result_expected,result);
          end
        end
        
      endcase
      end
    endtask

  initial begin
    $monitor("%0t A = %0d B = %0d reset_n = %0d start = %0d opcode = %s done = %0d result = %0d",$realtime,A,B,reset_n,start,opcode,done,result);
  end
endmodule
