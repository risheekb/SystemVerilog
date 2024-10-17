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
  
  opcode_t expect_q[$];
  initial begin
    @(posedge clk)
    reset_n <= 1'b0;
    repeat(5) @(posedge clk);
    reset_n <= 1'b1;

    repeat(100) begin
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
    endtask

    task send_transaction;
      @(posedge clk) #1ns;
      start = 1'b1;
      generate_transaction();
      wait(done)
      start = 1'b0;
      expect_q.push_back(opcode);
    endtask

    task check_transaction;
      wait(done)
      case(expect_q.pop_front())
        NOP: begin
          if(result != 'z)
            $error("mismatch for NOP");
        end
        ADD: begin
          if(result != A + B)
            $error("mismatch for ADD");
        end
        SUB: begin
          if(result !== A - B) begin
            $error();
            $strobe("@%0t mismatch for SUB expected = %0d actual = %0d",$realtime,(A-B),result);
          end
          else
            $display("SELF CHECK WORKS");
        end
        NOT: begin
          if(result != ~A)
            $error("mismatch for NOT");
        end
        AND: begin
          if(result != A & B)
            $error("mismatch for AND");
        end
        MUL: begin
          if(result != A * B)
            $error("mismatch for MUL");
        end
        INC: begin
          if(result != (A+B+1'b1))
            $error("mismatch for INC");
        end
      endcase
    endtask

  initial begin
    $monitor("%0t A = %0d B = %0d reset_n = %0d start = %0d opcode = %s done = %0d result = %0d",$realtime,A,B,reset_n,start,opcode,done,result);

  end
endmodule
