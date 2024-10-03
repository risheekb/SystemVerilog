module instr_register 
  import instr_register_pkg::*;
  ( input logic clk,
    input logic reset_en,
    input logic load_en,
    input index_t read_index,
    input index_t write_index,
    input operand_t operand_a,
    input operand_t operand_b,
    input opcode_t opcode,
    output instruction_t instruction
  );
  
  instruction_t IRW [DEPTH-1:0];

  always_ff @(posedge clk,negedge reset_en) begin
    if(!reset_en) begin
     foreach(IRW[i])
       IRW[i] = '{opc:ZERO,default:0};
    end
    else begin
      if(load_en)
        IRW[write_index] = '{opcode,operand_a,operand_b}; 
    end
  end
  assign instruction = IRW[read_index]; //CONTINOUSLY READ FROM THE IW REGISTER 
endmodule
