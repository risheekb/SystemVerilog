module instr_register 
  import instr_register_pkg::*;
  (input logic clk,instr_register_inf io);
  
  instruction_t IRW [DEPTH-1:0];

  always_ff @(posedge clk,negedge io.reset_en) begin
    if(!io.reset_en) begin
     foreach(IRW[i])
       IRW[i] <= '{opc:ZERO,default:0};
    end
    else begin
      if(io.load_en) begin
        IRW[io.write_index] <= '{io.opcode,io.operand_a,io.operand_b}; 
        if($test$plusargs("FORCE_LOAD_ERROR"))// when enabled injects a bug in the design for the testbench to catch. 
          IRW[io.write_index] <= '{io.opcode,io.operand_a,io.operand_a}; 
      end
    end
  end
  assign io.instruction = IRW[io.read_index]; //CONTINOUSLY READ FROM THE IW REGISTER 

endmodule
