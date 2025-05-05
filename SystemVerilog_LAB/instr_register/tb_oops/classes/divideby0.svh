class DivideBy0 extends Transaction;

  virtual function void randomize_transaction();
    opcode = DIV;
    operand_a = $urandom_range(1,100);
    operand_b = 0;
  endfunction

  virtual function void print_transaction();
  endfunction

  virtual function Transaction clone();
  endfunction
endclass
