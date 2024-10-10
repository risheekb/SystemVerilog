class Transaction;
  opcode_t opcode;
  operand_t operand_a, operand_b;
  index_t index;

  virtual function void randomize_transaction();
    this.opcode = opcode_t'($urandom_range(0,7)); //randomizing the opcode for the register
    this.operand_a = $urandom_range(1,100); //randomizing the operand_a
    this.operand_b = $urandom_range(1,100);//randomizing the operand_b
  endfunction

  virtual function void print_transaction();
      $display("%0t %m index = %0d opcode = %s operand_a = %0d operand_b = %0d",$realtime,this.index,this.opcode,this.operand_a,this.operand_b);
  endfunction

  virtual function void copy(Transaction rhs_h);
    this.opcode = rhs_h.opcode;
    this.operand_a = rhs_h.operand_a;
    this.operand_b = rhs_h.operand_b;
    this.index = rhs_h.index;
  endfunction

  virtual function Transaction clone();
    clone = new();
    clone.copy(this);
  endfunction


endclass
