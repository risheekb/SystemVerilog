class TransOne extends Transaction;

  constraint c_allone {data == '1;}

  function void print_transaction;
    $display("TransOne::");
    super.print_transaction;
  endfunction

  virtual function Transaction clone();
    clone = TransOne::new();
    clone.copy(this);
  endfunction


endclass
