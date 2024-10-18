module tinyalu
  import alu_pkg::*;
  (input operand_t A,
    input operand_t B,
    input logic clk,
    input logic reset_n,
    input logic start,
    input opcode_t opcode,
    output result_t result,
    output logic done); 


  always_ff @(posedge clk) begin
    if(!reset_n) begin
      result = '0;
      done = 1'b0;
    end
    else begin
      if(start) begin
        case(opcode)
          NOP: begin
              done <= 1'b1;
          end
          ADD:begin
              result  <=  A + B;
              done    =  1'b1;
          end
          SUB:begin
              result <= A - B;
              done  = 1'b1;
          end
          NOT:begin
              result <= ~A;
              done = 1'b1;
          end
          XOR:begin
            result <= A ^ B;
            done = 1'b1;
          end
          AND:begin
            result <= A & B;
            done = 1'b1;
          end
          MUL:begin
            result = repeat(2) @(posedge clk) A *B;
            done = 1'b1;
          end
          INC:begin
            result = repeat(2) @(posedge clk) (A+B+1'b1);
            done = 1'b1;
          end
        endcase
      end
      else begin
        done = 1'b0;
        result = 'z;
      end
    end
  end
  initial begin
    if($test$plusargs("ERROR_INJECT"))
      force result = $random;
  end
endmodule
