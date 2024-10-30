class Driver extends Component;
  virtual instr_register_inf v_io;

  mailbox #(Transaction) gen2drv_h;

  function new(virtual instr_register_inf io);
    this.v_io = io;
  endfunction

  virtual task reset();
    $display("Applying reset");
   
    v_io.write_index  <= '0;              // initialize write pointer
    v_io.read_index   <= '1;              // initialize read pointer
    v_io.load_en      <= 1'b0;            // initialize load enable
    v_io.reset_en      <= 1'b0;            // assert reset_n (active low)
    repeat (2) @(posedge v_io.clk);       // hold in reset for 2 clock cycles
    v_io.reset_en      <= 1'b1;  
  endtask

  virtual task run(int n);
    repeat(n) begin
      Transaction trans_h;
      gen2drv_h.get(trans_h);
      send(trans_h);
    end
  endtask

  task send(Transaction trans_h);
    @(posedge v_io.clk) #1ns;
    v_io.load_en      <= 1'b1;
    v_io.opcode       <= trans_h.opcode;
    v_io.operand_a    <= trans_h.operand_a;
    v_io.operand_b    <= trans_h.operand_b;
    v_io.write_index  <= trans_h.index;
    //#5;
     @(posedge v_io.clk) #1ns;
     v_io.load_en <= 1'b0;
  endtask

  virtual task check(int n);
    repeat(n) begin
      Transaction trans_h;
      gen2drv_h.get(trans_h);
      send_check(trans_h.index);
    end

  endtask


  task send_check(index_t index); //starting a read transaction
    @(posedge v_io.clk) #1ns; 
    v_io.read_index <= index;
    #9ns;
    v_io.read_index <= 'x;
  endtask
endclass

