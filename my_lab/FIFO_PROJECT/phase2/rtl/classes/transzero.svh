class TransZero extends Transaction;


  constraint c_allone {data == 0;}

  virtual function void print_transaction;
    $display("ZeroTransaction::");
    super.print_transaction();
  endfunction

  virtual function Transaction clone();
    clone = TransZero::new();
    clone.copy(this);
  endfunction



endclass
