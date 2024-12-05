class Transaction extends Component;
  
  rand data_t data;
  logic [$clog2(DEPTH)-1:0] index;


  virtual function void print_transaction;
    $display("location = %0d data = %0h",index,data);
  endfunction


  virtual function void copy(Transaction rhs);
    this.data = rhs.data;
    this.index = rhs.index;
  endfunction

  virtual function Transaction clone();
    clone = Transaction::new();
    clone.copy(this);
  endfunction
endclass
