class Monitor;
  virtual instr_register_inf v_io;
  Scoreboard scbd_h;

  function new(virtual instr_register_inf v_io,Scoreboard scbd_h);
    this.v_io = v_io;
    this.scbd_h = scbd_h;
  endfunction

  task run(int n);
    Transaction trans_h;
    repeat(n) begin
      trans_h = new();
      @(posedge v_io.load_en)
      //#8ns;
      trans_h.opcode    = v_io.opcode;
      trans_h.operand_a = v_io.operand_a;
      trans_h.operand_b = v_io.operand_b;
      trans_h.index     = v_io.write_index;
      //$display("%m :: adding trans %p",trans_h);
      scbd_h.add_input(trans_h);
    end
  endtask

  task check(int n);
    //$display("%m %p",v_io);
    repeat(n) begin
      @(v_io.read_index)
      #8ns;
      scbd_h.check_output(v_io.instruction,v_io.read_index); 
    end
  endtask
endclass
