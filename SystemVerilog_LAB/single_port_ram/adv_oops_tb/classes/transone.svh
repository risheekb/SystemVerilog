class TransOne extends Transaction;

  virtual function void randomize_transaction();
    this.data_in = '1;
  endfunction

  virtual function void print_transaction();
    $display("Transaction ONE:: ");
    super.print_transaction();
  endfunction

  virtual function Transaction clone();
    clone = TransOne::new();
    clone.copy(this);
  endfunction
  
endclass
