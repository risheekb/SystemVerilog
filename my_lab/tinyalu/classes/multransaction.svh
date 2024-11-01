class MULTransaction extends Transaction;
  
  constraint op_c {soft opcode == MUL;}
 
  virtual function void print_transaction();
    $display("MULTransaction");
    super.print_transaction();
  endfunction

  virtual function Transaction clone();
    clone = MULTransaction::new();
    clone.copy(this);
  endfunction

endclass
