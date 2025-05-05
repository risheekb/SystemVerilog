module dut(input logic        clk,
	   input logic 	      reset_n,
	   input logic  [7:0] d,
	   output logic [7:0] q);

  int force_error=0;
  initial begin
    if ($test$plusargs("FORCE_ERROR")) begin
      if (! $value$plusargs("FORCE_ERROR=%d", force_error))
        $error("+FORCE_ERROR=n must have a value - the cycle to cause error");
    end
  end

//   initial $monitor("@%t DUT: clk=%b, rst=%b, d=%d., q=%d.", $time, clk, reset_n, d, q);

   always_ff @(posedge clk or negedge reset_n) begin
      if (reset_n === 1'b0)
	q <= 0;
      else begin
        if (--force_error == 0) begin
          $display("\n****************\nForcing error\n****************\n");
          q <= ~d;
        end
        else
          q <= d;
      end
   end

endmodule : dut

