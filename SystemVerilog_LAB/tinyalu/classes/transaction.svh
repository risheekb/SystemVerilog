class Transaction extends Component;
  rand operand_t A;
  rand operand_t B;
  rand opcode_t opcode;
  result_t result;

  virtual function void print_transaction();
    $display("%0t :: A = %0d B = %0d opcode = %s result = %0d",$realtime,A,B,opcode,result);
  endfunction
  
  virtual function void copy(Transaction rhs);
    this.A = rhs.A;
    this.B = rhs.B;
    this.opcode = rhs.opcode;
    this.result = rhs.result;
  endfunction

  virtual function Transaction clone();
    clone = Transaction::new();
    clone.copy(this);
  endfunction

endclass
