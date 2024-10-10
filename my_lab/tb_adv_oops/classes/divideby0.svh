class DivideBy0 extends Transaction;

  virtual function void randomize_transaction();
    super.randomize_transaction();
    opcode = DIV;
    operand_b = 0;
  endfunction

  virtual function void print_transaction();
    $write("DivideBy0:");
    super.print_transaction();
  endfunction

  virtual function Transaction clone();
    clone = DivideBy0::new();
    clone.copy(this);
  endfunction
endclass
