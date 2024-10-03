module instr_register_test
  import instr_register_pkg::*;
  (input logic clk,
  output logic reset_en,
  output logic load_en,
  output index_t read_index,
  output index_t write_index,
  output operand_t operand_a,
  output operand_t operand_b,
  output opcode_t opcode,
  input  instruction_t instruction);
 
  instruction_t tr;
  instruction_t que[$];

  initial begin

    @(posedge clk);
    reset_en <= 1'b0;
    #20; // hold the reset for 20 clocks
    @(posedge clk);
    reset_en <= 1;
    write_index <= '0; // initialize the read and write pointers
    read_index <= '0;
    load_en <= 1'b0;
    send_transaction();
    read_transaction();
    #100 
    $finish;
  end

   task send_transaction();
     //generate random values for the transaction and then send it over to the DUT.
    @(posedge clk) #1ns;
    load_en <=1;
    for(int i = 0;i<DEPTH;i++) begin
      tr = '{opcode_t'($urandom_range(0,7)),$urandom_range(1,100),$urandom_range(1,100)}; 
      @(posedge clk);
      opcode    <= tr.opc;
      operand_a <= tr.op_a;
      operand_b <= tr.op_b;
      write_index <= i;
      #5;
      que.push_back(tr);  // push the value of the transaction to the queue for scoreboard
      $display("%0t write_index = %0d opcode = %s operand_a = %0d operand_b = %0d",$realtime,write_index,tr.opc,tr.op_a,tr.op_b);
    end
    @(posedge clk) #1ns;
    load_en <= 0;
  endtask
  task  read_transaction();
    for(int i = 0;i<DEPTH;i++)begin
      @(posedge clk);
      read_index <= i;
      #5;
      if(instruction != que[i]) //check the value in the que if not equal then pop
        $display("@%0t Entry mismatch :: expected value = %p Actual Value =%p",$realtime,que.pop_front,instruction);
      else 
        $display("%0t read_index = %0d instruction = %p ",$realtime,read_index,instruction);
    end
  endtask

endmodule

