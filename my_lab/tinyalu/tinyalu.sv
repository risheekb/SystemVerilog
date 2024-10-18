module tinyalu
  import alu_pkg::*;
  (alu_interface inf); 


  always_ff @(posedge inf.clk) begin
    if(!inf.reset_n) begin
      inf.result = '0;
      inf.done = 1'b0;
    end
    else begin
      if(inf.start) begin
        case(inf.opcode)
          NOP: begin
              inf.done <= 1'b1;
          end
          ADD:begin
              inf.result  <=  inf.A + inf.B;
              inf.done    =  1'b1;
          end
          SUB:begin
              inf.result <= inf.A - inf.B;
              inf.done  = 1'b1;
          end
          NOT:begin
              inf.result <= ~inf.A;
              inf.done = 1'b1;
          end
          XOR:begin
            inf.result <= inf.A ^ inf.B;
            inf.done = 1'b1;
          end
          AND:begin
            inf.result <= inf.A & inf.B;
            inf.done = 1'b1;
          end
          MUL:begin
            inf.result = repeat(2) @(posedge inf.clk) inf.A *inf.B;
            inf.done = 1'b1;
          end
          INC:begin
            inf.result = repeat(2) @(posedge inf.clk) (inf.A+inf.B+1'b1);
            inf.done = 1'b1;
          end
        endcase
      end
      else begin
        inf.done = 1'b0;
        inf.result = 'z;
      end
    end
  end
  initial begin
    if($test$plusargs("ERROR_INJECT"))
      force inf.result = $random;
  end
endmodule
