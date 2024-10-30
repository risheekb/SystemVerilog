class Monitor extends Component;
  virtual instr_register_inf v_io;
  Scoreboard scbd_h;

  mailbox #(Transaction) mon_in_h,mon_out_h;

  function new(virtual instr_register_inf v_io,Scoreboard scbd_h);
    this.v_io = v_io;
    this.scbd_h = scbd_h;
  endfunction

  virtual task run(int n);
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
      mon_in_h.put(trans_h);
      //scbd_h.add_input(trans_h);
    end
  endtask

  virtual task check(int n);
    repeat(n) begin
      Transaction trans_h;
      trans_h = new();
      @(v_io.read_index)
      #8ns;
    //$display("%m %p",v_io.operand_a);
      trans_h.opcode = v_io.instruction.opc;
      trans_h.operand_a = v_io.instruction.op_a;
      trans_h.operand_b = v_io.instruction.op_b;
      trans_h.index = v_io.read_index;

      mon_out_h.put(trans_h);
      //scbd_h.check_output(v_io.instruction,v_io.read_index); 
    end
  endtask
endclass
