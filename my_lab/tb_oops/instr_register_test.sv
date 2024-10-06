module instr_register_test
  import instr_register_pkg::*;
  (instr_register_inf io); 
  instruction_t tr;
  instruction_t que[$];
  `include "instr_register_inf.sv"
  `include "classes/transaction.svh"
  `include "classes/driver.svh"
  `include "classes/generator.svh"
  `include "classes/scoreboard.svh"
  `include "classes/monitor.svh"
  `include "classes/basetest.svh"
  Transaction trans_h;
  initial begin

    trans_h = new();
    
    @(posedge io.clk);
    io.reset_en <= 1'b0;
    #20; // hold the reset for 20 clocks
    @(posedge io.clk);
    io.reset_en <= 1;
    io.write_index <= '0; // initialize the read and write pointers
    io.read_index <= '0;
    io.load_en <= 1'b0;
    
    send_transaction();

    read_transaction();
    #100 
    $finish;
  end

   task send_transaction();
     //generate random values for the transaction and then send it over to the DUT.
     @(posedge io.clk) #1ns;
     io.load_en <=1;
     for(int i = 0;i<DEPTH;i++) begin
       trans_h.randomize_transaction();
       trans_h.print_transaction();
       trans_h.index = i;
       //tr = '{opcode_t'($urandom_range(0,7)),$urandom_range(1,100),$urandom_range(1,100)}; 
       @(posedge io.clk);
       io.opcode    <= trans_h.opcode;
       io.operand_a <= trans_h.operand_a;
       io.operand_b <= trans_h.operand_b;
       io.write_index <= trans_h.index;
       #5;
       que.push_back(instruction_t'({trans_h.opcode,trans_h.operand_a,trans_h.operand_b}));  // push the value of the transaction to the queue for scoreboard
     end
     @(posedge io.clk) #1ns;
     io.load_en <= 0;
   endtask


   task  read_transaction();
     for(int i = 0;i<DEPTH;i++)begin
       @(posedge io.clk);
       io.read_index <= i;
       #5;
       if(io.instruction != que[i]) //check the value in the que if not equal then pop
         $display("@%0t Entry mismatch :: expected value = %p Actual Value =%p",$realtime,que.pop_front,io.instruction);
       else 
         $display("%0t read_index = %0d instruction = %p ",$realtime,io.read_index,io.instruction);
     end
   endtask
endmodule

